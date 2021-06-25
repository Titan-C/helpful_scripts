;;; trim-vid.el Cut some parts of a video out -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Óscar Nájera
;;
;; Author: Óscar Nájera <https://github.com/titan-c>
;; Maintainer: Óscar Nájera <hi@oscarnajera.com>
;; Created: June 25, 2021
;; Modified: June 25, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Utility functions to create the ffmpeg commants to slice and remerge slices of a video.
;;
;; There is the two step option of chunking and the concating all with copy render, super fast.
;;
;; The second option is with the filter_complex. Reencoding will happen. It is intel QSV hardware
;; accelerated.
;;
;; The slices are described on a separate two column csv file.
;;
;;; Code:

(require 'subr-x)
(require 'cl-macs)
(require 'dash)
(require 'f)

(defun trim-timestamp-to-secs (str)
  "Transform a time STR from hh:mm:ss.ms into only seconds as a float.
Values are taken from smallest seconds to hours."
  (->> (split-string str":")
    (mapcar #'string-to-number)
    reverse
    (--zip-with (* it other) '(1 60 3600))
    -sum))

(defun trim-import-slices-from-csv (filepath)
  "Naive csv read in FILEPATH."
  (->> (f-read-text filepath)
    split-string
    (--map (split-string it ","))
    (--map (mapcar #'trim-timestamp-to-secs it))))

(defun trim-slice-filter (idx start end)
  "For each slice in START - END at a given order IDX create the trim instruction for audio and video."
  (string-join
   (cl-loop for (track prefix) in '(("v" "") ("a" "a")) collect
            (format "[0:%s]%strim=start=%g:end=%g,%ssetpts=PTS-STARTPTS[%d%s];"
                    track prefix start end prefix idx track))))

(defun trim-concat-slices (slices)
  "Concatenate instruction for all SLICES."
  (concat
   (apply #'concat (--map-indexed (format "[%dv][%da]" it-index it-index) slices))
   (format "concat=n=%d:v=1:a=1[outv][outa]" (length slices))))

(defun trim-cmd-slicing (slices infile outfile)
  "FFMPEG intel QSV hardaware acceleraced reconstruction of SLICES of INFILE into OUTFILE command."
  (concat (format "ffmpeg -y -hwaccel qsv -c:v h264_qsv -i %s -filter_complex \"" infile)
          (apply #'concat (--map-indexed (trim-slice-filter it-index (car it) (cadr it)) slices))
          (trim-concat-slices slices)
          (format "\" -map '[outv]' -map '[outa]' -c:v h264_qsv -c:a aac %s" outfile)))

(defun trim-slices-to-chunk-files (slices infile)
  "Copy render break the INFILE into the SLICES."
  (write-region  ;; write a list.txt with all the chunks
   (string-join
    (--map (format "file 'sli-out%d.mkv'" it)
           (number-sequence 0 (- (length points) 1)))
    "\n")
   nil
   "list.txt")
  (string-join (--map-indexed
                (-let (((start end) it))
                  (format "ffmpeg -y -ss %g -i %s -t %g -c copy slice-out%d.mkv"
                          start infile (- end start) it-index )) slices)
               " && "))

(let* ((slices (trim-import-slices-from-csv "keep.csv"))
       (cmd (trim-cmd-slicing slices "~/sour.mkv" "out.mkv")))
  cmd
  ;;(async-shell-command  cmd (get-buffer-create "OUT") (get-buffer-create "ERR"))
  )

(let* ((points (trim-import-slices-from-csv "keep.csv"))
       (cmd (trim-slices-to-chunk-files points "~/sourc.mkv")))
  cmd
  ;;(async-shell-command  cmd (get-buffer-create "OUT") (get-buffer-create "ERR"))
  )

;;(async-shell-command "ffmpeg -y -f concat -i  list.txt -c copy sli.mkv")

(provide 'trim-vid)
;;; trim-vid.el ends here
