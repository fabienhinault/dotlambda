#lang racket/base

(require dotlambda/implementation
         typed/racket/base
         (for-syntax racket/base))

(make-#%module-begin new-#%module-begin
                     #%module-begin
                     λ
                     define-syntax
                     make-rename-transformer)
(make-#%top-interaction new-#%top-interaction
                        #%top-interaction
                        λ
                        define-syntax
                        make-rename-transformer)

(provide (except-out (all-from-out typed/racket/base)
                     #%module-begin
                     #%top-interaction)
         (except-out (all-from-out dotlambda/implementation)
                     make-#%module-begin
                     make-#%top-interaction)
         (rename-out [new-#%module-begin #%module-begin]
                     [new-#%top-interaction #%top-interaction]))