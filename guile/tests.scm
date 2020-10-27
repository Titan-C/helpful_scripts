#!/usr/bin/guile \
--no-auto-compile -e main -s
!#

(include "/home/titan/dev/helpful_scripts/bank.scm")

(use-modules
 (ice-9 and-let-star)
 (language tree-il)
 (term ansi-color)
 (srfi srfi-64))

(define (%test-write-result1 pair port)
  (format port (string-append (colorize-string  "  ~a: " 'BOLD) "~s~%")
          (car pair) (cdr pair)))

(define (test-on-test-end-color runner)
  (let ((log (test-runner-aux-value runner))
	(kind (test-result-ref runner 'result-kind))
        (results (test-result-alist runner)))
    (when (memq kind '(fail xpass))
      (display (colorize-string (if (eq? kind 'xpass) "XPASS" "FAIL") 'RED))
      (map (lambda (y)
             (and-let* ((x (assq y results)))
               (format #t ":~a" (cdr x))))
           '(source-file source-line test-name))
      (newline))
    (when (output-port? log)
      (display "Test end:\n" log)
      (map (lambda (pair)
	     ;; Write out properties not written out by on-test-begin.
             (unless (memq (car pair) '(test-name source-file source-line source-form))
	       (%test-write-result1 pair log)))
           results))))

(test-runner-factory
 (lambda ()
   (let ((runner (test-runner-simple)))
     (test-runner-on-test-end! runner test-on-test-end-color)
     runner)))

;; Initialize and give a name to a simple testsuite.
(test-begin "parse bank csv")
(test-equal "2020-12-08" (reformat-date "8.12.2020"))
(test-equal "1966-07-02" (reformat-date "2.7.1966"))
(test-equal "item 5.00 EUR" (replace "item 5,00 EUR" "," "."))
(test-equal "First" (drop-edge-quotes "\"First\""))
;; Finish the testsuite, and report results.
(test-equal "2020-10-16,RUN  last,-7.79 EUR\n" (reformat "foo;16.10.2020;bar;\"RUN, last\";-7,79;mo"))
(test-end "parse bank csv")
