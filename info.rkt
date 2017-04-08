#lang info
(define collection "dotlambda")
(define deps '("base"
               "rackunit-lib"
               "phc-toolkit"
               "typed-map-lib"
               "typed-racket-lib"
               "typed-racket-more"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "typed-racket-doc"))
(define scribblings '(("scribblings/dotlambda.scrbl" ())))
(define pkg-desc
  "Splits dotted identifiers like a.b.c, also supports λ<arg>.code syntax")
(define version "0.1")
(define pkg-authors '(georges))
