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
    
(define-condition no-such-char-error (error)
  ((code :initarg :code :accessor code)))

(defmethod print-object ((obj no-such-char-error) stream)
  (with-slots (code) obj
    (format stream "No valid character for code: ~S" code)))

(defun to-char (code)
  "CODE-CHAR, except more portable across implementations.
   Signals a correctable error of type NO-SUCH-CHAR-ERROR if CODE does
   not correspond to a valid character under the implementation's
   character encoding.

   Provides a USE-VALUE restart for the user to provide a different character."
  (restart-case (let ((char (handler-case (code-char code)
                              (error () nil))))
                  (if char
                      char
                      (error 'no-such-char-error :code code)))
    (use-value (char)
      :interactive (lambda () (list (read-from-string (prompt-value))))
      :report "Supply a character to be used instead (in Lisp representation.)"
      char)))
