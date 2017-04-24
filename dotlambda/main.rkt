#lang racket/base

(require dotlambda/implementation
         (for-meta -10 racket/base)
         (for-meta -9 racket/base)
         (for-meta -8 racket/base)
         (for-meta -7 racket/base)
         (for-meta -6 racket/base)
         (for-meta -5 racket/base)
         (for-meta -4 racket/base)
         (for-meta -3 racket/base)
         (for-meta -2 racket/base)
         (for-meta -1 racket/base)
         (for-meta 0 racket/base)
         (for-meta 1 racket/base)
         (for-meta 2 racket/base)
         (for-meta 3 racket/base)
         (for-meta 4 racket/base)
         (for-meta 5 racket/base)
         (for-meta 6 racket/base)
         (for-meta 7 racket/base)
         (for-meta 8 racket/base)
         (for-meta 9 racket/base)
         (for-meta 10 racket/base))

(make-#%module-begin new-#%module-begin
                     #%module-begin
                     λ
                     define-syntax
                     make-rename-transformer
                     #%plain-app
                     syntax)
(make-#%top-interaction new-#%top-interaction
                        #%top-interaction
                        λ
                        define-syntax
                        make-rename-transformer
                        #%plain-app
                        syntax)

(provide (except-out (all-from-out racket/base)
                     #%module-begin
                     #%top-interaction)
         (except-out (all-from-out dotlambda/implementation)
                     make-#%module-begin
                     make-#%top-interaction)
         (rename-out [new-#%module-begin #%module-begin]
                     [new-#%top-interaction #%top-interaction]))