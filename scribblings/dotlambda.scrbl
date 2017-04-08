#lang scribble/manual
@require[@for-label[dotlambda]]

@title{Dotted identifiers and @racket[λ<arg>.code] syntax}
@author[@author+email["Georges Dupéron" "georges.duperon@gmail.com"]]

@(begin
   (module orig racket/base
     (require scribble/manual
              typed/racket/base)
     (provide orig:#%module-begin)
     (define orig:#%module-begin (racket #%module-begin)))
   (require 'orig))

@defmodulelang[dotlambda]{
 This @hash-lang[] language overrides @orig:#%module-begin from
 @racketmodname[typed/racket/base], and splits identifiers which contain dots,
 following these rules:
 @itemlist[
 @item{A single dot splits the identifier, and the dot is replaced with
   @racket[#%dot-separator]. If an identifier is split by one or more
   non-consecutive dots, all the resulting identifiers, including the
   occurrences @racket[#%dot-separator] are placed in a syntax list, starting
   with @racket[#%dotted-id], so that @racket[a.b.c] gets transformed into
   @racket[(#%dotted-id a #%dot-separator b #%dot-separator c)].}
 @item{A leading dot (which is not followed by another dot) is allowed, and is
   replaced with @racket[#%dot-separator], like dots occurring in the middle of
   the identifier.}
 @item{A dot immediately preceded or followed by an ellipsis @racket[…] can be
   omitted, so that @racket[a.….b], @racket[a….b], @racket[a.…b] and
   @racket[a…b] are all translated to
   @racket[(#%dotted-id a #%dot-separator … #%dot-separator b)].}
 @item{Two or more dots do not split the identifier, but one of the dots is
   removed (i.e. it escapes the other dots).}
 @item{If an identifier ends with a dot, a single trailing dot is removed and
   the identifier is otherwise left intact (i.e. the trailing dot escapes the
   whole identifier).}
 @item{Identifiers consisting only of dots are left unchanged, as well as the
   following: @racket[..+], @racket[...+], @racket[..*], @racket[...*],
   @racket[…], @racket[…+], @racket[…*] and @racket[::...].}]

 Furthermore the syntax @racket[λvar.(expr …)] is recognised as a shorthand for
 @racket[(λ (var) (expr …))], so that @racket[λx.(+ x 2)] is translated to
 @racket[(λ (x) (+ x 2))]. If the @racket[_var] part is left empty, then it
 defaults to @racket[%], so that @racket[λ.(+ % 2)] is translated to
 @racket[(λ (%) (+ % 2))].}

@section{Module language for @racket[dotlambda]}

@defmodulelang[dotlambda/lang]{
 This language is equivalent to
 @racket[#,(hash-lang) #,(racketmodname dotlambda)], but can also be used as
 a module language.
}


