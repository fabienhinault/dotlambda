#lang racket

(require dotlambda/unhygienic-implementation)

(provide (rename-out [new-#%module-begin #%module-begin]
                     #;[new-#%top-interaction #%top-interaction]))