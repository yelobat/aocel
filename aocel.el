;;; aocel.el --- Advent of Code tooling for Emacs -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025 Luke Holland
;;
;; Author: Luke Holland
;; Maintainer: Luke Holland
;; Created: September 24, 2025
;; Modified: September 24, 2025
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex text tools unix vc wp
;; Homepage: https://github.com/yelobat/aocel
;; Package-Requires: ((emacs "27.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;; The goal of this package is to provide easy problem solution
;; execution on a particular input without having to context-switch
;; to your browser. All that is required is that you `setenv'
;; the `AOC_COOKIE' environment variable to be equal to your session-cookie
;; found in your browser after you login at https://adventofcode.com.
;;
;; The session cookie can be extracted by opening the network tab
;; when you inspect the site's page source. Refresh the page and let the network
;; tab capture the traffic. From here, locate to the cookies tab and you should
;; see the session cookie. Copy the value and set this using:
;; `(setenv AOC_COOKIE <session-cookie>)'.
;;
;;; Code:

(require 'url)
(require 'url-http)

(defgroup aocel nil
  "Interface for Advent of Code problems."
  :group 'aocel)

(defvar aocel--cache (make-hash-table :test #'equal)
  "Cache for the AOC input for YEAR and DAY.")

(defun aocel--key (year day)
  (format "%d-%d" year day))

(defun aocel--cache-put (year day input)
  "Insert INPUT into the `aocel-cache' with key YEAR-DAY."
  (let ((key (aocel--key year day)))
    (puthash key input aocel--cache)))

(defun aocel--cache-get (year day)
  "Get the input for YEAR and DAY from `aocel-cache'."
  (let ((key (aocel--key year day)))
    (gethash key aocel--cache)))

(defun aocel-solve (year day solution)
  "Solve the problem on YEAR and DAY with SOLUTION."
  (let* ((cookie (getenv "AOC_COOKIE"))
        (url (format "https://adventofcode.com/%d/day/%d/input" year day))
        (url-request-method "GET")
        (url-request-extra-headers `(("Cookie" . ,cookie))))
    (if (not cookie)
        (error "AOC_COOKIE environment variable is not set"))
    (let ((input (aocel--cache-get year day)))
      (if input
          (funcall solution input)
        (url-retrieve url (lambda (status)
                            (when (buffer-live-p (current-buffer))
                              (goto-char url-http-end-of-headers)
                              (let ((input (buffer-substring (point) (point-max))))
                                (funcall solution (aocel--cache-put year day input))))))))))

(provide 'aocel)
;;; aocel.el ends here
