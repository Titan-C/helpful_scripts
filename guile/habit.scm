#!/usr/bin/guile \
-e main-rofi -s
!#

(add-to-load-path "/home/titan/dev/helpful_scripts/guile/")

(use-modules (ice-9 rdelim)
             (ice-9 popen)
             (ice-9 ftw)
             (ice-9 format)
             (ice-9 and-let-star)
             (utils))

(define habits-dir (expand-file "~/org/habits/"))

(define (get-habit-files dir)
  (scandir dir (lambda (file) (string-suffix? ".dat" file))))

(define (prepare-options files)
  (string-join (map (lambda (name) (string-drop-right name 4)) files) "\n"))

(define (rofi-capture-option options)
  (let* ((cmd (format #f "echo -e ~s | rofi -dmenu" options))
         (port (open-input-pipe cmd))
         (option (read-line port)))
    (close-pipe port)
    (if (eof-object? option) #f option)))

(define (rofi-capture-habit-quantity habit)
  (let* ((cmd (format #f "echo 1 | rofi -dmenu -p 'Add to ~a'" habit))
         (port (open-input-pipe cmd))
         (quantity (read-line port)))
    (close-pipe port)
    (if (eof-object? quantity) #f quantity)))

(define (main-rofi args)
  (and-let* ((habit (rofi-capture-option (prepare-options (get-habit-files habits-dir))))
             (quantity (rofi-capture-habit-quantity habit))
             (file-out (open-file (string-append habits-dir habit ".dat") "a")))
    (format file-out "~d:~a\n" (current-time) quantity)
    (close-port file-out)))
