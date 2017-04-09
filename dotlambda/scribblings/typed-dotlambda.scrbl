#lang scribble/manual
@require[@for-label[@only-in[dotlambda #%dot-separator #%dotted-id]
                    racket/stxparam]]

@title{Typed version of @racketmodname[dotlambda]}

@(begin
   (module orig-typed/racket/base racket/base
     (require scribble/manual
              typed/racket/base)
     (provide typed/racket/base:#%module-begin
              typed/racket/base:#%top-interaction)
     (define typed/racket/base:#%module-begin (racket #%module-begin))
     (define typed/racket/base:#%top-interaction (racket #%top-interaction)))
   (require 'orig-typed/racket/base))

@defmodulelang[typed/dotlambda]{
 Like @racket[#,(hash-lang) dotlambda], but overrides
 @typed/racket/base:#%module-begin and @typed/racket/base:#%top-interaction
 from @racketmodname[typed/racket/base], instead.}
