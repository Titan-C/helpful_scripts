#!/usr/bin/guile \
-L guile --no-auto-compile -e main -s
!#

(use-modules
 (ice-9 and-let-star)
 (ice-9 getopt-long)
 (ice-9 popen)
 (ice-9 regex)
 (ice-9 rdelim)
 (utils))

(define (reformat-date date-str)
  (strftime "%Y-%m-%d"
            (catch 'system-error
              (lambda () (car (strptime "%d.%m.%Y" date-str)))
              (lambda (key . args) (localtime (current-time))))))

(define (replace str pattern new)
  (regexp-substitute/global #f pattern str 'pre new 'post))

(define (drop-edge-quotes str)
  (let ((str-len (string-length str)))
    (if (and (char=? (string-ref str 0) #\")
             (char=? (string-ref str (1- str-len )) #\"))
        (substring str 1 (1- str-len))
        str)))

(define (reformat line)
  (let* ((cols   (string-split line #\;))
         (date   (reformat-date (list-ref cols 1)))
         (payee  (drop-edge-quotes (replace (list-ref cols 3) "," " ")))
         (amount (replace (list-ref cols 4) "," ".")))
    (string-join (list date payee (string-append amount " EUR\n")) ",")))

(define (trim-bank-csv csv-file-path)
  (let ((file-in (open-input-file csv-file-path))
        (file-out (open-output-file "/tmp/jus")))
    (read-line file-in) ;; Consume header
    (display "date,payee,amount\n" file-out)
    (do ((line (read-line file-in) (read-line file-in))) ((eof-object? line))
      (display (reformat line) file-out))
    (close-port file-out)
    (close-port file-in)))

(define (write-ledger-entries w-port)
  (let ((port (open-input-pipe "ledger convert /tmp/jus -f ~/dev/journal/accout_setup.ledger --account \"Assets:Commerzbank Vorteil\" --invert --rich-data -y %Y-%m-%d")))
    (do ((line (read-line port) (read-line port))) ((eof-object? line))
      (display line w-port)
      (newline w-port))
    (close-pipe port)))


(define (main args)
  (let* ((option-spec '((version (single-char #\V) (value #f))
                        (help    (single-char #\h) (value #f))))
         (options (getopt-long args option-spec))
         (help-wanted (option-ref options 'help #f))
         (version-wanted (option-ref options 'version #f)))
    (if (or version-wanted help-wanted)
        (begin
          (if help-wanted
              (display "\
usage: bank.scm file

Create Ledger entries from bank csv

positional arguments:
  file        csv file from Bank

optional arguments:
  -h, --help  show this help message and exit
  -V, --version    Display version
"))
          (if version-wanted
              (display "bank importer version 0.1\n")))
        (and-let* ((args (option-ref options '() #f))
                   (csv-file (and (not (null? args)) (car args)))
                   (csv-path (and (not (string-null? csv-file)) (expand-file csv-file))))
          (when (file-exists? csv-path)
            (trim-bank-csv csv-path)
            (call-with-output-file "/tmp/ledi" write-ledger-entries))))))
