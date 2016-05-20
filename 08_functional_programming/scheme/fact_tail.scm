#! /usr/bin/env gosh

(define (fact_tail n acc)
  (if (zero? n)
      acc
      (fact_tail (- n 1) (* n acc))))

(fact_tail 100000 1)
#(for-each (lambda (x) (fact_tail 1000 1)) (iota 1000))
