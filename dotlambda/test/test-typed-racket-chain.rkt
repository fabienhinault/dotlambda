#lang dotlambda/unhygienic typed/racket
(require typed/rackunit)
(define l λ.(list % 1))
(check-equal? ((ann l (→ Any (Listof Any))) "b")
              '("b" 1))