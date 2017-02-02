# TRIVIAL-ESCAPES [![Quicklisp](http://quickdocs.org/badge/trivial-escapes.svg)](http://quickdocs.org/trivial-escapes/) [![Build Status](https://travis-ci.org/williamyaoh/trivial-escapes.svg?branch=master)](https://travis-ci.org/williamyaoh/trivial-escapes) [![Coverage Status](https://coveralls.io/repos/github/williamyaoh/trivial-escapes/badge.svg?branch=master)](https://coveralls.io/github/williamyaoh/trivial-escapes?branch=master)

Copyright (c) 2017 William Yao

## Description and usage

Ever been annoyed by the fact that Common Lisp doesn't interpret escape
characters the same way that literally every other programming language does?
Hey, me too!

So I wrote this library.

It provides a readtable (four, actually) that lets you write strings like this:

```lisp
CL-USER> #"This string has\na newline in it!"
"This string has
a newline in it!"

CL-USER> #"\x4E00\x751F\x61F8\x547D"
"一生懸命"
```

Fun! To use it, use one of the exported readtables. In most cases,
`TRIVIAL-ESCAPES:READTABLE` is probably the one you want, containing the
standard readtable, with a dispatch function for `#\# #\"` added in.

```lisp
(named-readtables:in-readtable trivesc:readtable)
```

However, if you need them, there are three other provided readtables as well.
`TRIVIAL-ESCAPES:READTABLE-MIXIN` contains *just* the dispatch function for
`#\# #\"` (this means that it doesn't contain **any** other reader macros!
as in, `#\(` will no longer start s-expressions, for example.), and similarly,
`TRIVIAL-ESCAPES:DQ-READTABLE-MIXIN` contains *just* a reader macro for `#\"`,
replacing the normal string reading.

`TRIVIAL-ESCAPES:READTABLE` and `TRIVIAL-ESCAPES:DQ-READTABLE` simple fuse
the standard readtable with their respective mixins, creating actually usable
readtables. In most cases, one of these two is what you want.

**TRIVIAL-ESCAPES** contains all the *standard* C escapes sequences, shown
[here](https://en.wikipedia.org/wiki/Escape_sequences_in_C#Table_of_escape_sequences).

Note that as a technicality, the characters you end up with will depend upon
whatever character encoding your Lisp environment uses. But since everyone
seems to be standardizing on Unicode, this probably won't be a problem.
