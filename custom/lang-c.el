;;; -*- coding: utf-8-unix; -*-
;;; Emacs-DevTools - An easy emacs setup for developers
;;;
;;; Copyright (C) 2012 by it's authors.
;;; All rights reserved. See LICENSE, AUTHORS.
;;;
;;; lang-c.el --- Editing options for C


;;; see http://www.emacswiki.org/emacs/IndentingC for explanation
(setq-default c-default-style "linux"
              c-basic-offset 2)

;;; Idea from http://ergoemacs.org/emacs/elisp_determine_cursor_inside_string_or_comment.html
(defun smart-newline-and-indent ()
  (interactive)
  (if (and (nth 4 (syntax-ppss)) (not (nth 7 (syntax-ppss))))
      (progn
        (setq-local comment-padding " * ")
        (c-indent-new-comment-line)
        (setq-local comment-padding " "))
    (newline-and-indent)))

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'case-label 2)
            (define-key c-mode-map (kbd "\r") 'smart-newline-and-indent)))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq comment-padding " * ")
            (define-key c++-mode-map (kbd "\r") 'smart-newline-and-indent)))

(provide 'lang-c)
