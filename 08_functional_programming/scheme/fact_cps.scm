#! /usr/bin/env gosh

(define (fact/cps n cont)
  (if (zero? n)
      (cont 1)
      (fact/cps (- n 1) (lambda (x) (cont (* n x))))))

(fact/cps 100000 (lambda (x) x))
#(for-each (lambda (x) (fact/cps 1000 (lambda (x) x))) (iota 1000))
