;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; traad.el --- emacs interface to the traad xmlrpc refactoring server.
;;
;; Author: Austin Bingham <austin.bingham@gmail.com>
;; Version: 0.1
;; URL: https://github.com/abingham/traad
;;
;; This file is not part of GNU Emacs.
;;
;; Copyright (c) 2012 Austin Bingham
;;
;; Description:
;;
;; traad is an xmlrpc server built around the rope refactoring library. This
;; file provides an API for talking to that server - and thus to rope - from
;; emacs lisp. Or, put another way, it's another way to use rope from emacs.
;;
;; For more details, see the project page at
;; https://github.com/abingham/traad.
;;
;; Installation:
;;
;; Make sure xml-rpc.el is in your load path. Check the emacswiki for more info:
;;
;;    http://www.emacswiki.org/emacs/XmlRpc
;;
;; Copy traad.el to some location in your emacs load path. Then add
;; "(require 'traad)" to your emacs initialization (.emacs,
;; init.el, or something). 
;; 
;; Example config:
;; 
;;   (require 'traad)
;;
;; License:
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

(require 'xml-rpc)

(defvar traad-host "localhost.localdomain"
  "The host on which the traad server is running.")

(defvar traad-port 6942
  "The port on which the traad server is listening.")

(defun traad-get-all-resources ()
  "Get all resources in a project."
  (traad-call 'get_all_resources))

(defun traad-get-children (path)
  "Get all child resources for PATH. PATH may be absolute or relative to
the project root."
  (traad-call 'get_children path))

(defun traad-rename (new-name path &optional offset)
  "Rename PATH (or the subelement at OFFSET) to NEW-NAME."
  (if offset
      (traad-call 'rename new-name path offset)
      (traad-call 'rename new-name path)))

(defmacro traad-call (func &rest args)
  "Make an XMLRPC to FUNC with ARGS on the traad server."
  `(xml-rpc-method-call 
    (concat 
     "http://" ,traad-host ":" 
     (number-to-string ,traad-port))
    ,func ,@args))

(provide 'traad)