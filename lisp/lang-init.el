;;; -*- coding: utf-8-unix; -*-
;;; Emacs-DevTools - An easy emacs setup for developers
;;;
;;; Copyright (C) 2017 by it's authors.
;;; All rights reserved. See LICENSE, AUTHORS.
;;;
;;; lang-init.el --- Languague-specific initialization

(require 'devtools-common)

;;;###autoload
(defun lang/init ()
  "Initialize language-specific configuration"
  (lang-smartparens-init)
  (lang-rainbow-delimiters)
  (lang-cucumber-init)
  (lang-web-init)
  (lang-markdown-init))

(defun lang-smartparens-init ()
  (require 'smartparens-config)
  (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
  (add-hook 'web-mode-hook 'smartparens-mode)
  (sp-local-pair 'web-mode "{" nil :post-handlers '(:add curly-braces-on-enter) :when '(("RET"))))

(defun curly-braces-on-enter (id action context)
  (when (eq action 'insert)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

(defun lang-rainbow-delimiters ()
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'web-mode-hook 'rainbow-delimiters-mode))

(defun lang-cucumber-init ()
  (setq feature-default-i18n-file (concat devtools-data-dir "i18n.yml"))
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode)))

(defun lang-web-init ()
  (add-hook 'web-mode-hook 'devtools-web-mode-hook)
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (eval-after-load "web-mode"
    '(progn
       (setq web-mode-content-types-alist
	     '(("jsx" . "\\.js[x]?\\'"))))))

(defun devtools-web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t))

(defun lang-markdown-init ()
  (eval-after-load "markdown-mode"
    '(progn
       (define-key markdown-mode-map (kbd "C-c C-c t") 'markdown-toc-generate-toc))))

(provide 'lang-init)
