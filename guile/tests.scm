#!/usr/bin/guile \
-L . --no-auto-compile -s
!#

(use-modules
 (ice-9 and-let-star)
 (language tree-il)
 (term ansi-color)
 (srfi srfi-64)
 (mail-tools)
 (utils))

(define (%test-write-result1 pair port)
  (simple-format port (string-append (colorize-string  "  ~a: " 'BOLD) "~s~%")
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

(include "/home/titan/dev/helpful_scripts/bank.scm")
(test-begin "parse bank csv")
(test-equal "2020-12-08" (reformat-date "8.12.2020"))
(test-equal "1966-07-02" (reformat-date "2.7.1966"))
(test-equal "item 5.00 EUR" (replace "item 5,00 EUR" "," "."))
(test-equal "First" (drop-edge-quotes "\"First\""))
(test-equal "2020-10-16,RUN  last,-7.79 EUR\n" (reformat "foo;16.10.2020;bar;\"RUN, last\";-7,79;mo"))
(test-end "parse bank csv")

(test-begin "Mail tools")
(test-equal "mail/spam/cur/postU=5" (new-path "mail/inbox/cur/postU=5" "mail/spam"))
(test-equal 60 (call-with-input-string "1595684247\n60\n" get-uidvalidity))
(test-equal "Ha;S" (rename-higher "Ha,U=55;S" 5))
(test-equal "Ha,U=20;S" (rename-higher "Ha,U=20;S" 55))
(test-equal '("+one -new" "(from:first) and tag:new") (with-new '("+one" "from:first") #t))
(test-equal '("+one" "from:first") (with-new '("+one" "from:first") #f))
(test-equal '(" -new" "tag:new") (with-new '("" "*") #t))
(test-equal '("" "*") (with-new '("" "*") #f))
(test-end "Mail tools")

(test-begin "Thread macros")
(test-equal '(+ 5 9) (tree-il->scheme (macroexpand '(-> 5 (+ 9)))))
(test-equal '(+ 8) (tree-il->scheme (macroexpand '(-> 8 +))))
(test-equal '(string-append (number->string (inc 8)) " EUR")
  (tree-il->scheme (macroexpand '(-> 8 inc number->string (string-append " EUR")))))
(test-equal "29 EUR" (-> 28 1+ number->string (string-append " EUR")))

(test-equal '(2)
    (-> (->> '(5 9 2) (cons 1) (filter even?))
        macroexpand
        tree-il->scheme))

(test-end "Thread macros")
