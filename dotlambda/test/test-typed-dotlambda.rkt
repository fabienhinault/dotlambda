#lang typed/dotlambda

(require (rename-in typed/rackunit [check-equal? check-equal?:])
         ;"get.lp2.rkt"
         ;"graph-test.rkt"
         typed-map
         (for-syntax racket/base))

(require racket/stxparam)

(check-equal?:
 (syntax-parameterize ([#%dotted-id (make-rename-transformer #'list)])
   (let ([x 1] [y 2] [z 3] [#%dot-separator '|.|])
     (list 'x.y
           '.x.y
           x.y
           .x.y)))
 '((#%dotted-id x #%dot-separator y)
   (#%dotted-id #%dot-separator x #%dot-separator y)
   (1 |.| 2)
   (|.| 1 |.| 2)))

(check-equal?: (let ([v 4]) v.sqrt.-) -2)

(let ((foo..bar 42))
  (check-equal?: foo..bar 42))

(define di '#%dotted-id)
(define d '#%dot-separator)

(check-equal?: 'foo.bar (list di 'foo d 'bar))

;; Srcloc tests:
;(let .a b) ;; Error on the whole .a
;(let .a.b b) ;; Error on the whole .a.b
;(let a.b b) ;; Error on the whole a.b

#|
TODO: re-enable or move these tests.
(check-equal?: g.streets…houses…owner.name
               : (Listof (Listof String))
               (list (list "Amy" "Anabella") (list "Jack")))
(check-equal?: (map: (curry map .owner.name) g.streets…houses)
               : (Listof (Listof String))
               (list (list "Amy" "Anabella") (list "Jack")))
|#
  
(define (slen [n : Index] [str : String])
  (check-equal?: (string-length str) n)
  (string->symbol str))
  
(check-equal?: '(a . b) (cons 'a 'b))
(check-equal?: '(a . b.c) (list 'a di 'b d 'c))
(check-equal?: '(a . b.c.d) (list 'a di 'b d 'c d 'd))
(check-equal?: '(a.c . b) (cons (list di 'a d 'c) 'b))
(check-equal?: '(a.c.d . b) (cons (list di 'a d 'c d 'd) 'b))
  
(check-equal?: '.aa.bb..cc.d (list di d 'aa d (slen 5 "bb.cc") d 'd))
(check-equal?: '…aa...bb..cc.d (list di '… d (slen 9 "aa..bb.cc") d 'd))
(check-equal?: '.…aa...bb..cc.d (list di d '… d (slen 9 "aa..bb.cc") d 'd))
(check-equal?: '…aa.….bb..cc.d
               (list di '… d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '.…aa.….bb..cc.d
               (list di d '… d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '.aa.….bb..cc.d (list di d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '.aa.….bb.cc.d (list di d 'aa d '… d 'bb d 'cc d 'd))
(check-equal?: '…aa.….bb.cc.d (list di '… d 'aa d '… d 'bb d 'cc d 'd))
(check-equal?: '.…aa.….bb.cc.d (list di d '… d 'aa d '… d 'bb d 'cc d 'd))
  
(check-equal?: 'aa.bb..cc.d (list di 'aa d (slen 5 "bb.cc") d 'd))
(check-equal?: 'aa...bb..cc.d (list di (slen 9 "aa..bb.cc") d 'd))
(check-equal?: 'aa…bb..cc.d (list di 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: 'aa.….bb..cc.d (list di 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: 'aa.….bb.cc.d (list di 'aa d '… d 'bb d 'cc d 'd))

(check-equal?: 'aa…bb (list di 'aa d '… d 'bb))
(check-equal?: 'aa… (list di 'aa d '…))
(check-equal?: 'aa…. (slen 3 "aa…"))
(check-equal?: 'aa.. (slen 3 "aa."))
(check-equal?: 'aa... (slen 4 "aa.."))
  
(check-equal?: '… (slen 1 "…"))
(check-equal?: '…+ (slen 2 "…+"))
(check-equal?: '... (slen 3 "..."))
(check-equal?: '...+ (slen 4 "...+"))

(check-equal?: (λx.(+ x x) 3) 6)
(check-equal?: (λy.(+ y y) 3) 6)
(check-equal?: (λ.(+ % %) 3) 6)
(check-equal?: (λy.(+ y) 3) 3)
(check-equal?: (λy. y.sqrt.- 4) -2)
(check-equal?: (.sqrt.- 4) -2)

(check-equal?: '…aa.…bb..cc.d (list di '… d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '…aa….bb..cc.d (list di '… d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '.…aa.…bb..cc.d
               (list di d '… d 'aa d '… d (slen 5 "bb.cc") d 'd))
(check-equal?: '.…aa….bb..cc.d
               (list di d '… d 'aa d '… d (slen 5 "bb.cc") d 'd))


(check-equal?: (map λx.(* x x) '(1 2 3)) '(1 4 9))
(check-equal?: (map λ.(* % %) '(1 2 3)) '(1 4 9))
(check-equal?: (map λ.(* %1 %2) '(1 2 3) '(10 100 1000)) '(10 200 3000))
(check-equal?: (map λx.y.(* x y) '(1 2 3) '(10 100 1000)) '(10 200 3000))

;; Factorial function, works only in untyped racket due to recursion:
;; ((λ.(if (> % 0) (* %1 (%0 (sub1 %))) 1)) 5)