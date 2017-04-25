#lang info
(define collection 'multi)
(define deps '("base"
               "rackunit-lib"
               "typed-map-lib"
               "typed-racket-lib"
               "typed-racket-more"
               "chain-module-begin"
               "debug-scopes"))
(define build-deps '("scribble-lib"
                     "racket-doc"
                     "typed-racket-doc"))
(define compile-omit-paths '("dotlambda/dotlambda/test/test-hyper-literate-chain.rkt"
                             "dotlambda/test/test-hyper-literate-chain.rkt"))
(define test-omit-paths '("dotlambda/dotlambda/test/test-hyper-literate-chain.rkt"
                          "dotlambda/test/test-hyper-literate-chain.rkt"))
(define pkg-desc
  "Splits dotted identifiers like a.b.c, also supports λ<arg>.(code) syntax")
(define version "0.2")
(define pkg-authors '("Georges Dupéron"))
