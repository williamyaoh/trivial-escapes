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

(in-package #:trivial-escapes)

(named-readtables:defreadtable readtable-mixin
  (:macro-char #\# :dispatch)
  (:dispatch-macro-char #\# #\" #'read-string-escaping))
(named-readtables:defreadtable readtable
  (:fuse :standard readtable-mixin))
(named-readtables:defreadtable dq-readtable-mixin
  (:macro-char #\" #'read-string-escaping))
(named-readtables:defreadtable dq-readtable
  (:fuse :standard dq-readtable-mixin))
