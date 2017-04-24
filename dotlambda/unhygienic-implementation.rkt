#lang racket
(provide #%dotted-id
         #%dot-separator
         new-#%module-begin
         make-#%top-interaction)

(require typed/racket
         "chain.rkt")
(require (for-syntax debug-scopes))

(require racket/stxparam
         (for-syntax racket/string
                     racket/list
                     syntax/parse
                     racket/syntax
                     syntax/strip-context
                     racket/struct
                     racket/function
                     syntax/srcloc
                     "private/fold.rkt"
                     (only-in racket/base [... …])))

(define-for-syntax identifier→string (compose symbol->string syntax-e))

(define-syntax (#%dot-separator stx)
  (raise-syntax-error '#%dot-separator
                      "Can only be used in special contexts"
                      stx))

(define-syntax (~> stx)
  (syntax-case stx ()
    [(_ v) #'v]
    [(_ v f . f*) #'(~> (f v) . f*)]))

(define-syntax-parameter #%dotted-id
  (syntax-parser
    #:literals (#%dot-separator)
    [(_ {~seq #%dot-separator e} …) #'(λ (v) (~> v e …))]
    [(_ e₀ {~seq #%dot-separator e} …) #'(~> e₀ e …)]))

(define-syntax (new-#%module-begin stx)
  (syntax-parse stx
    [(_ {~or lang:id (lang:id . chain₊)} . body)
     (datum->syntax
      stx
      `(,#'chain-module-begin ,#'lang ,@(if (attribute chain₊) `(,#'chain₊) '())
                              . ,(fold-syntax replace-dots #'body))
      stx
      stx)]))

(define-syntax (make-#%top-interaction stx)
  (syntax-case stx ()
    [(_ name wrapped-#%top-interaction)
     #'(define-syntax (name stx2)
         (syntax-case stx2 ()
           [(_ . body)
            (datum->syntax
             stx2
             `(,#'wrapped-#%top-interaction
               . ,(fold-syntax replace-dots
                               #'body))
             stx2
             stx2)]))]))

(define-for-syntax (make-λ l args e percent?)
  (define %-loc
    (build-source-location-list
     (update-source-location l
                             #:position (let ([p (syntax-position l)])
                                          (and p (+ p 1)))
                             #:column (let ([c (syntax-column l)])
                                        (and c (+ c 1)))
                             #:span 1)))
  (define percent*
    (if (and percent? (>= (length args) 1))
        #`{(define-syntax #,(datum->syntax l '% %-loc)
             (#%plain-app make-rename-transformer #'#,(car args)))}
        #'{}))
  ;`(letrec ([%0 (,#'λ ,args ,@percent* ,e)]) %0)
  (define -λ
    (datum->syntax #'here 'λ
                   (build-source-location-list
                    (update-source-location l #:span 1))))
  (datum->syntax l #`(#,-λ #,args #,@percent* #,e) l l))

(define-for-syntax (make-args l str* pos)
  (if (empty? str*)
      '()
      (let ()
        (define str (car str*))
        (define len (string-length str))
        (cons (datum->syntax l
                             (string->symbol str)
                             (update-source-location l
                                                     #:position pos
                                                     #:span len)
                             l)
              (make-args l (cdr str*) (+ pos 1 len))))))

(define-for-syntax (find-% stx)
  (define found 0)
  (define (found! n) (set! found (max found n)))
  (fold-syntax (λ (e recurse)
                 (if (and (identifier? e)
                          (regexp-match #px"^%[1-9][0-9]*$"
                                        (identifier→string e)))
                     (found! (string->number
                              (cadr (regexp-match #px"^%([1-9][0-9]*)$"
                                                  (identifier→string e)))))
                     (if (and (identifier? e)
                              (string=? (identifier→string e) "%"))
                         (found! 1)
                         (recurse e))))
               stx)
  found)

(begin-for-syntax
  (define-splicing-syntax-class elt
    (pattern {~seq {~and l {~datum λ.}} e:expr}
             #:with expanded
             (let ([args (for/list ([arg (in-range 1 (add1 (find-% #'e)))])
                           (datum->syntax #'l
                                          (string->symbol (format "%~a" arg))
                                          #'l
                                          #'l))])
               (make-λ #'l args #'e #t)))
    (pattern {~seq l:id e:expr}
             #:when (regexp-match #px"^λ([^.]+\\.)+$" (identifier→string #'l))
             #:with expanded
             (let* ([m (regexp-match* #px"[^.]+" (identifier→string #'l) 1)]
                    [args (make-args #'l
                                     m
                                     (+ (syntax-position #'l) 1))])
               (make-λ #'l args #'e #f)))
    (pattern e
             #:with expanded #'e)))

(define-for-syntax (replace-dots stx recurse)
  (syntax-parse stx
    ;; Fast path: no dots or ellipses.
    [x:id #:when (regexp-match #px"^[^.…]*$" (identifier→string #'x))
          #'x]
    ;; Protected identifiers, which are not altered.
    [x:id #:when (regexp-match #px"^(\\.*|…|\\.\\.\\.?[+*]|…[+*]|::\\.\\.\\.)$"
                               (identifier→string #'x))
          #'x]
    ;; A trailing dot is dropped and escapes the preceding identifier.
    [x:id #:when (regexp-match #px"\\.$" (identifier→string #'x))
          (let* ([str (identifier→string #'x)]
                 [unescaped (substring str 0 (sub1 (string-length str)))])
            (datum->syntax stx (string->symbol unescaped) stx stx))]
    [x:id #:when (regexp-match #px"[.…]"
                               (identifier→string #'x))
          (let* ([str (symbol->string (syntax-e #'x))]
                 [leading-dot? (regexp-match #px"^\\." str)]
                 [components* (regexp-match* #px"([^.…]|\\.\\.+)+|…"
                                             str
                                             #:gap-select? #t)]
                 [components (if leading-dot?
                                 (drop-right components* 1)
                                 (cdr (drop-right components* 1)))]
                 [unescaped (map (λ (m)
                                   (regexp-replace* #px"\\.(\\.+)" m "\\1"))
                                 components)]
                 [identifiers ((to-ids stx) components
                                            unescaped
                                            0
                                            leading-dot?)]
                 [trailing-dot? (regexp-match #px"\\.$" str)])
            (define/with-syntax (id …) identifiers)
            (if (= (length identifiers) 1)
                (quasisyntax/loc stx
                  #,(car identifiers))
                (quasisyntax/loc stx
                  (#,(datum->syntax #'here '#%dotted-id stx stx) id …))))]
    [{~and whole (:elt … . {~and tail {~not (_ . _)}})}
     ;; TODO: keep the stx-pairs vs stx-lists structure where possible.
     (recurse (datum->syntax #'whole
                             (syntax-e #'(expanded … . tail))
                             #'whole
                             #'whole))]
    [_ (recurse stx)]))

(define-for-syntax (to-ids stx)
  (define (process component* unescaped* len-before dot?)
    (if (empty? component*)
        '()
        (let ()
          (define component (car component*))
          (define unescaped (car unescaped*))
          (define len (string-length component))
          (define len-after (+ len-before len))
          (define pos (+ (syntax-position stx) len-before))
          (define loc (update-source-location stx #:position pos #:span len))
          (define id
            (datum->syntax stx
                           (if dot?
                               '#%dot-separator
                               (string->symbol unescaped))
                           loc
                           stx))
          (define id-p
            (if dot? (syntax-property id 'dotted-original-chars unescaped) id))
          (cons id-p
                (process (cdr component*)
                         (cdr unescaped*)
                         len-after
                         (not dot?))))))
  process)

(define-for-syntax (map-fold f init . l*)
  (car
   (apply foldl
          (λ all-args
            (define vs+acc (last all-args))
            (define args (drop-right all-args 1))
            (define new-v+new-acc (apply f (append args (list (cdr vs+acc)))))
            (cons (cons (car new-v+new-acc)
                        (car vs+acc))
                  (cdr new-v+new-acc)))
          (cons '() init)
          l*)))