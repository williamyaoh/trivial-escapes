# TRIVIAL-ESCAPES

Copyright (c) 2017 William Yao

## Description and usage

Ever been annoyed by the fact that Common Lisp doesn't interpret escape
characters the same way that literally every other programming language does?
Hey, me too!

So I wrote this library.

It provides a readtable (two, actually) that lets you write strings like this:

```lisp
#"This string has\na newline in it!"
 =>
 "This string has
  a newline in it!"
 
#"\x4E00\x751F\x61F8\x547D"
 => "一生懸命"
```

Fun! To use it, use one of the two readtables, either
`:trivial-escapes-readtable` or `:trivial-escapes-readtable-mixin`.

```lisp
(named-readtables:in-readtable :trivial-escapes-readtable
```

In most cases, `:trivial-escapes-readtable` is probably what you want. It's just
the standard readtable with a dispatch function for `#\# #\"` added in.
`:trivial-escapes-readtable-mixin` has *just* the dispatch function in it.

**TRIVIAL-ESCAPES** contains all the *standard* C escapes sequences, shown
[here](https://en.wikipedia.org/wiki/Escape_sequences_in_C#Table_of_escape_sequences).

Note that as a technicality, the characters you end up with will depend upon
whatever character encoding your Lisp environment uses. But since everyone
seems to be standardizing on Unicode, this probably won't be a problem.
