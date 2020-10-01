#!/usr/bin/guile \
--no-auto-compile -e main -s
!#

(include "/home/titan/dev/helpful_scripts/bank.scm")

(use-modules
 (srfi srfi-64))

;; Initialize and give a name to a simple testsuite.
(test-begin "parse bank csv")
(test-equal "2020-12-08" (reformat-date "8.12.2020"))
(test-equal "1966-07-02" (reformat-date "2.7.1966"))
(test-equal "item 5.00 EUR" (replace "item 5,00 EUR" "," "."))
(test-equal "First" (drop-edge-quotes "\"First\""))
;; Finish the testsuite, and report results.
(test-equal "2020-10-16,RUN  last,-7.79 EUR\n" (reformat "foo;16.10.2020;bar;\"RUN, last\";-7,79;mo"))
(test-end "parse bank csv")
