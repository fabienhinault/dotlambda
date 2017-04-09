#lang info
(define collection 'multi)
(define deps '("base"
               "rackunit-lib"
               "typed-map-lib"
               "typed-racket-lib"
               "typed-racket-more"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "typed-racket-doc"))
(define pkg-desc
  "Splits dotted identifiers like a.b.c, also supports λ<arg>.(code) syntax")
(define version "0.2")
(define pkg-authors '("Georges Dupéron"))
