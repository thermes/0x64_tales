#! /usr/bin/env gosh

(define (fact n)
  (if (zero? n)
      1
      (* n (fact (- n 1)))))

(fact 100000)
#(for-each (lambda (x) (fact 1000)) (iota 1000))
