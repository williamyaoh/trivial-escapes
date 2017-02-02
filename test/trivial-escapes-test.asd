(defsystem #:trivial-escapes-test
  :author "William Yao <williamyaoh@gmail.com>"
  :maintainer "William Yao <williamyaoh@gmail.com>"
  :serial t
  :depends-on ("fiveam"
               "asdf"
               "uiop"

               "trivial-escapes")
  :components ((:file "packages")
               (:file "trivial-escapes-test"))
  :perform (test-op (o s)
             (uiop:symbol-call :fiveam '#:run!
               (uiop:find-symbol* '#:|#"-test-cases|
                                  '#:trivial-escapes-test))))
