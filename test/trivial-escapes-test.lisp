(in-package #:trivial-escapes-test)

;; Trying to test this package is a little bit weird, since there's the
;; possibility of errors at _read_ time, which means they'll happen before
;; our testing framework actually sees them. Instead, we'll read from a file,
;; so that our read-time errors happen at run-time.

;; Each file in the subdirectory `test-cases/` should be a text file, containing
;; two Lisp forms. The second of these is a form using the `#"` syntax, which
;; is what we're testing.

;; The _first_ is either a symbol, or a list/string. If it's a symbol, this test
;; case is expected to error, and the symbol is the type of the error (symbol
;; read in TRIVIAL-ESCAPES). If it's a list, it should be a form which evaluates
;; to a string, which is then STRING= checked against the second form in the
;; file. If it's a string, then... it just gets checked against the second form.

(defparameter *test-case-directory*
  (uiop:subpathname (asdf:system-source-directory '#:trivial-escapes-test)
                    "test-cases/"))

(test |#"-test-cases|
  (dolist (filename (uiop:directory-files *test-case-directory*))
    (let ((*readtable* (named-readtables:find-readtable 'readtable)))
      ;; Rebinding *STANDARD-INPUT* is necessary so that we bind it dynamically.
      ;; See the EVAL below.
      (with-open-file (*standard-input* filename :direction :input)
        (let ((spec (read)))
          (if (symbolp spec)
              (eval `(signals ,spec (read))) ; EVAL is necessary because FIVEAM:SIGNAL
                                             ; doesn't eval the error name.
              (is (string= (eval spec) (read))
                  "Strings not equal in test case ~A"
                  (file-namestring filename))))))))
