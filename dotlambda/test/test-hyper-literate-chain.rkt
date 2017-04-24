#lang hyper-literate (dotlambda/unhygienic . typed/racket)
@chunk[<*>
       (require typed/rackunit)
       (define l λ.(list % 1))
       (check-equal? ((ann l (→ Any (Listof Any))) "b")
                     '("b" 1))]