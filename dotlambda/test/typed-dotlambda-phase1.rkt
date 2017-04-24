#lang typed/dotlambda
(require (for-syntax racket/base))
(begin-for-syntax
  λ.(+ % 1))