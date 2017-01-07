;;                      THE LICENSE THAT'S NOT A LICENSE
;;                        Version 1.618, January 2017
;; 
;;     Redistribution of this LICENSE is permitted, either in unmodified
;;         form, with no further qualifications, or in modified form,
;;        under the condition that the name of the license is changed.
;; 
;;                      THE LICENSE THAT'S NOT A LICENSE
;;   TERMS AND CONDITIONS FOR USAGE, COPYING, DISTRIBUTION, AND MODIFICATION
;;                          OF PROVIDED SOFTWARE
;; 
;; 
;;  1. Do WHATEVER YOU WANT with the provided software.
;;  2. Credit is appreciated, but not required.
;; 
;; 
;;     This software is provided with NO WARRANTY, implied or otherwise.        

;;;;
;;;;                            TRIVIAL-ESCAPES                                 
;;;;                  William Yao, <williamyaoh@gmail.com>                      
;;;;                           Copyright (c) 2017                               
;;;;

(in-package #:asdf)
(defsystem #:trivial-escapes
  :author "William Yao <williamyaoh@gmail.com>"
  :maintainer "William Yao <williamyaoh@gmail.com>"
  :description "C-style escape directives for Common Lisp."
  :version "1.0.0"
  :serial t
  :depends-on ("named-readtables")
  :components ((:file "escaping-pains")
               (:file "readtable")))
