[![Build Status,](https://img.shields.io/travis/jsmaniac/dotlambda/master.svg)](https://travis-ci.org/jsmaniac/dotlambda)
[![Coverage Status,](https://img.shields.io/codecov/c/github/jsmaniac/dotlambda/master.svg)](https://codecov.io/gh/jsmaniac/dotlambda)
[![Build Stats,](https://img.shields.io/badge/build-stats-blue.svg)](http://jsmaniac.github.io/travis-stats/#jsmaniac/dotlambda)
[![Online Documentation.](https://img.shields.io/badge/docs-online-blue.svg)](http://docs.racket-lang.org/dotlambda/)
[![Maintained as of 2018,](https://img.shields.io/maintenance/yes/2018.svg)](https://github.com/jsmaniac/dotlambda/issues)
[![License: CC0 v1.0.](https://img.shields.io/badge/license-CC0-blue.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

dotlambda
=========

Racket library which splits dotted identifiers like `a.b.c` into an expression starting with `#%dotted-id`. The semantics of `#%dotted-id` are customizable.

Also supports `λ<arg>.(code)` syntax, as an alternative implementation to AlexKnauth's [#lang afl](https://github.com/AlexKnauth/afl).