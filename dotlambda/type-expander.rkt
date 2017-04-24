#lang racket/base

(require dotlambda/implementation
         (for-meta -10 (only-meta-in 0 type-expander/lang))
         (for-meta -9 (only-meta-in 0 type-expander/lang))
         (for-meta -8 (only-meta-in 0 type-expander/lang))
         (for-meta -7 (only-meta-in 0 type-expander/lang))
         (for-meta -6 (only-meta-in 0 type-expander/lang))
         (for-meta -5 (only-meta-in 0 type-expander/lang))
         (for-meta -4 (only-meta-in 0 type-expander/lang))
         (for-meta -3 (only-meta-in 0 type-expander/lang))
         (for-meta -2 (only-meta-in 0 type-expander/lang))
         (for-meta -1 (only-meta-in 0 type-expander/lang))
         (for-meta 0 (only-meta-in 0 type-expander/lang))
         (for-meta 1 (only-meta-in 0 type-expander/lang))
         (for-meta 2 (only-meta-in 0 type-expander/lang))
         (for-meta 3 (only-meta-in 0 type-expander/lang))
         (for-meta 4 (only-meta-in 0 type-expander/lang))
         (for-meta 5 (only-meta-in 0 type-expander/lang))
         (for-meta 6 (only-meta-in 0 type-expander/lang))
         (for-meta 7 (only-meta-in 0 type-expander/lang))
         (for-meta 8 (only-meta-in 0 type-expander/lang))
         (for-meta 9 (only-meta-in 0 type-expander/lang))
         (for-meta 10 (only-meta-in 0 type-expander/lang))
         (only-in (for-meta -10 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -9 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -8 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -7 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -6 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -5 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -4 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -3 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -2 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta -1 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 0 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 1 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 2 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 3 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 4 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 5 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 6 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 7 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 8 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 9 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax])
         (only-in (for-meta 10 racket/base)
                  [make-rename-transformer -make-rename-transformer]
                  [#%plain-app -#%plain-app]
                  [syntax -syntax]))

(make-#%module-begin new-#%module-begin
                     #%module-begin
                     λ
                     define-syntax
                     -make-rename-transformer
                     -#%plain-app
                     -syntax)
(make-#%top-interaction new-#%top-interaction
                        #%top-interaction
                        λ
                        define-syntax
                        -make-rename-transformer
                        -#%plain-app
                        -syntax)

(provide (except-out (all-from-out type-expander/lang)
                     #%module-begin
                     #%top-interaction)
         (except-out (all-from-out dotlambda/implementation)
                     make-#%module-begin
                     make-#%top-interaction)
         (rename-out [new-#%module-begin #%module-begin]
                     [new-#%top-interaction #%top-interaction]))