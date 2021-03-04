#lang scribble/manual
@require[@for-label[@only-in[dotlambda
                             #%dot-separator
                             #%dotted-id
                             #%module-begin
                             #%top-interaction]
                    racket/stxparam]]

@title{Dotted identifiers and @racket[λ<arg>.code] syntax}
@author[@author+email["Suzanne Soy" "racket@suzanne.soy"]]

@(begin
   (module orig-racket/base racket/base
     (require scribble/manual)
     (provide racket/base:#%module-begin
              racket/base:#%top-interaction)
     (define racket/base:#%module-begin (racket #%module-begin))
     (define racket/base:#%top-interaction (racket #%top-interaction)))
   (require 'orig-racket/base))

@defmodulelang[dotlambda]{
 This @hash-lang[] language overrides @racket/base:#%module-begin and
 @racket/base:#%top-interaction from @racketmodname[racket/base], and splits
 identifiers which contain dots, following these rules:
 
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

 Furthermore the syntax @racket[λarg₁.arg₂.….argₙ.(expr …)] is recognised as a
 shorthand for @racket[(λ (arg₁ arg₂ … argₙ) (expr …))], so that
 @racket[λx.(+ x 2)] is roughly translated to @racket[(λ (x) (+ x 2))]. If the
 @racket[_var] part is left empty, then it defaults to @racket[%1], @racket[%2]
 and so on. The number of parameters is determined from the syntactical
 contents of the function's body, before performing macro-expansion. The term
 @racket[λ.(+ %1 %2)] is therefore roughly translated to
 @racket[(λ (%1 %2) (+ %1 %2))]. The variable named @racket[%] can be used as a
 shorthand for @racket[%1], so that @racket[λ.(+ % 10)] is therefore roughly
 translated to @racket[(λ (%) (+ % 10))].

 Since this substitution is performed on the whole program, before
 macro-expansion, these notations are performed regardless of the context in
 which an expression occurs. For example, the quoted term @racket['a.b] will
 also get translated to @racket['(#%dotted-id a #%dot-separator b)]. In this
 way, the @racket[#%module-begin] from @racket[dotlambda] works a bit like if
 it were a reader extension.

 @bold{Warning:} There probably are some issues with hygiene, especially in
 mixed contexts (e.g. literate programs, or typed/racket programs with untyped
 code at phase 1). I will think about these issues and adjust the behaviour in
 future versions. Future versions may therefore not be 100% backward-compatible
 with the current version, but the general syntax of dotted identifiers should
 hopefully not change much.}

@defform[#:kind "syntax parameter"
         (#%dotted-id ids-and-separators …)]{
 The default implementation currently translates @racket[a.b.c.d] to
 @racket[(d (c (b a)))], and @racket[.a.b.c] to
 @racket[(λ (x) (c (b (a x))))].

 This behaviour can be altered using @racket[syntax-parameterize]. I don't
 think syntax parameters can be modified globally for the whole containing file
 like parameters can (via @racket[(param new-value)]), so the exact mechanism
 used to customise the behaviour of @racket[#%dotted-id] may change in the
 future.}

@defidform[#%dot-separator]{
 Indicates the presence of a (possibly implicit) dot. The original string
 (usually @racket["."] or the empty string @racket[""] for an implicit dot
 before or after an ellipsis) is normally stored in the
 @racket['dotted-original-chars] syntax property of the occurrence of the
 @racket[#%dot-separator] identifier.}

@defform[(#%module-begin . body)]{Overridden form of
 @racket/base:#%module-begin and @racketmodname[racket/base]}

@defform[(#%top-interaction . expression)]{Overridden form of
 @racket/base:#%top-interaction from @racketmodname[racket/base]}

@include-section{typed-dotlambda.scrbl}