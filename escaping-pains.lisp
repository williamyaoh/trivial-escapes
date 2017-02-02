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

(defun simple-escape (char)
  "Used for implementing easy escape sequences, like backslash-n."
  (lambda (stream)
    (declare (ignorable stream))
    char))

(defun octal-digit-char-p (char) (find char "01234567"))
(defun hex-digit-char-p (char) (find char "0123456789abcdefABCDEF"))

(defun octal-reader (char)
  (lambda (stream)
    (to-char
     (parse-integer
      (with-output-to-string (s)
        (write-char char s)
        (loop repeat 2
              while (octal-digit-char-p (peek-char nil stream nil nil))
              do (write-char (read-char stream) s)))
      :radix 8))))

(defmacro admit (condition form else)
  `(let ((it ,form))
     (if ,condition it ,else)))

(defun hex-read (stream)
  (to-char
   (parse-integer
    (admit (> (length it) 0)
      (with-output-to-string (s)
        (loop while (hex-digit-char-p (peek-char nil stream nil nil))
              do (write-char (read-char stream) s)))
      (error "No hex digits found after \\x."))
    :radix 16)))

(defvar *simple-escapes*
  (map 'list
       (lambda (char escape)
         (list char (simple-escape escape)))
       "abfnrtv\\'\"?"
       (map 'list (lambda (obj) (if (characterp obj) obj (code-char obj)))
            '(#x07 #x08 #x0C #x0A #x0D #x09 #x0B #\\ #\' #\" #\?))))

(defvar *octal-escapes*
  (map 'list (lambda (char) (list char (octal-reader char)))
       "0123456789"))

(defvar *escape-functions*
  `(,@(apply #'append *simple-escapes*)
    ,@(apply #'append *octal-escapes*)
    #\x ,#'hex-read))

(defun read-string-escaping (stream char &optional numarg)
  (declare (ignorable char numarg))
  (with-output-to-string (s)
    (handler-case
        (loop for char = (read-char stream t nil t)
              while (char/= char #\")
              do (write-char
                  (if (char= char #\\)
                      (let* ((next (read-char stream t nil t))
                             (reader (getf *escape-functions* next)))
                        (if reader
                            (funcall reader stream)
                            (error "No valid escape character for \\~C." next)))
                      char)
                  s))
      (error (c)
        (clear-input stream)
        (error c)))))
