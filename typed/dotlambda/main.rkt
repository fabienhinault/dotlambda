#lang racket/base
;; Not sure if this file is necessary. For some reason, #lang typed/dotlambda
;; tries to access
;; /home/me/.racket/snapshot/pkgs/alexis-util/typed/dotlambda.rkt
;; unless there's a typed/dotlambda.rkt file. I would have expected the main.rkt
;; file to be selected here, but that's not the case.
(require "../dotlambda.rkt")
(provide (all-from-out "../dotlambda.rkt"))