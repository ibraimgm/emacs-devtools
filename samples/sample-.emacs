;;; -*- coding: utf-8-unix; -*-
;;; Emacs-DevTools - An easy emacs setup for developers
;;;
;;; Copyright (C) 2012 by it's authors.
;;; All rights reserved. See LICENSE, AUTHORS.
;;;
;;; sample-.emacs --- Sample .emacs configuration file

;; Add the custom scripts to load-path and bootstrap
;; the utility functions
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'devtools-bootstrap)

;; Now, the customization stuff. Those are generic settings, useful even if
;; don't plan to use emacs as a primary editor
;; (require 'general)       ; Basics: fonts, general indentation, etc.
;; (require 'colors)        ; Better color theme
;; (require 'ac)            ; Auto-complete support
;; (require 'ide)           ; The IDE, based on CEDET/ECB.

;; Common lisp support. You should uncomment 'custom-slime' and the desired
;; CL implementation. Note that inside the implementation file the function
;; 'enable-common-lisp-slime' is called to setup slime. While cumbersome, this
;; setup allows you to use different versions of slime for different lisps.
;; (require 'custom-slime)  ; General slime customizations
;; (require 'lang-sbcl)

;; Language support. Just uncomment the lines for the languages you want.
;; (require 'lang-cucumber) ; Allows editing of Gherkin (cucumber) user stories
;; (require 'lang-latex)    ; Enable latex editing and compilation (to pdf, by default)
;; (require 'lang-clojure)  ; Support for clojure/leiningen projects
;; (require 'lang-php)      ; Better editing for PHP
;; (require 'lang-c)        ; Some basic editing funcionality for C
;; (require 'lang-haskell)  ; Support for haskell, including GHCI and Cabal
;; (require 'lang-markdown) ; Markdown support

;; Save/Load custom variables in another file
;; If you want, you can use the file included in samples/sample-.emacs-custom
;; for a start point. Note that this file is (re)written automatically by
;; emacs custom configuration screens. I do recommend the use of this setup, so it's
;; easier to separate your personal configuration for backup purposes
;; (setq custom-file "~/.emacs-custom")
;; (load custom-file)
