(defpackage #:trivial-escapes-test
  (:use #:cl
        #:fiveam

        #:trivial-escapes)
  (:shadowing-import-from #:trivial-escapes #:readtable)
  (:export #:|#"-test-cases|))
