;;; -*- coding: utf-8-unix; -*-
;;; Emacs-DevTools - An easy emacs setup for developers
;;;
;;; Copyright (C) 2017 by it's authors.
;;; All rights reserved. See LICENSE, AUTHORS.
;;;
;;; completion-init.el --- Initialization of completion
;;; functionality

;;;###autoload
(defun completion/init ()
  "Initialize the completion framework"
  (global-set-key (kbd "C-c t") 'project-explorer-toggle)
  (setq counsel-git-grep-cmd-default "git --no-pager grep --full-name -n --no-color -i -e \"%s\"")
  (setq counsel-ag-base-command "ag --vimgrep --nocolor --nogroup %s")
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x g") 'magit-status)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  ;; ivy config
  (eval-after-load "ivy"
    '(progn
       (setq ivy-use-virtual-buffers t)
       (setq ivy-sort-matches-functions-alist
	     '((t)
	       (ivy-switch-buffer . ivy-sort-function-buffer)
	       (counsel-find-file . devtools-ivy-sort-files-function)))
       (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
       (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)))

  ;; dumb-jump
  (bind-lazy-cmds (("C-M-p" . dumb-jump-back)
		   ("C-M-g" . dumb-jump-go))
		  (dumb-jump-mode))

  ;;project commands
  (bind-lazy-cmds (("C-c p m" . projectile-commander)
		   ("C-c p t" . projectile-toggle-between-implementation-and-test)
		   ("C-c p P" . projectile-test-project)
		   ("C-c p c" . projectile-compile-project)
		   ("C-c p i" . projectile-invalidate-cache)
		   ("C-c p b" . counsel-projectile-switch-to-buffer)
		   ("C-c p d" . counsel-projectile-find-dir)
		   ("C-c p f" . counsel-projectile-find-file)
		   ("C-c p p" . counsel-projectile-switch-project))
		  (projectile-global-mode)
		  (counsel-projectile-on))

  ;; idle init
  (run-with-idle-timer
   1 nil
   (lambda ()
     (ivy-mode t)
     (ac-config-default)
     (configure-cheatsheet))))

(defun devtools-ivy-sort-files-function (_name candidates)
  (cl-sort (copy-sequence candidates)
           (lambda (x y)
             (string< (if (string-suffix-p "/" x) (substring x 0 -1) x)
                      (if (string-suffix-p "/" y) (substring y 0 -1) y)))))

(defmacro bind-lazy-cmds (commands &rest activation-forms)
  `(progn
     ,@(mapcar (lambda (e)
		 `(global-set-key (kbd ,(car e))
				  (lambda ()
				    (interactive)
				    ,@(mapcar (lambda (e)  `(global-unset-key (kbd ,(car e)))) commands)
				    ,@activation-forms
				    (,(cdr e)))))
	       commands)))

(defun configure-cheatsheet ()
  (cheatsheet-add :group 'Display :key "C-x C-+" :description "text-scale-adjust")
  (cheatsheet-add :group 'Navigation :key "C-c r" :description "iy-resume")
  (cheatsheet-add :group 'Navigation :key "C-c g" :description "counsel-git")
  (cheatsheet-add :group 'Navigation :key "C-c j" :description "counsel-git-grep")
  (cheatsheet-add :group 'Navigation :key "C-c k" :description "counsel-ag")
  (cheatsheet-add :group 'Navigation :key "C-M-g" :description "dumb-jump-go")
  (cheatsheet-add :group 'Navigation :key "C-M-p" :description "dumb-jump-back")
  (cheatsheet-add :group 'Project :key "C-x g" :description "magit-status")
  (cheatsheet-add :group 'Project :key "C-x M-g" :description "magit-file-popup")
  (cheatsheet-add :group 'Project :key "C-c t" :description "project-explorer-toggle")
  (cheatsheet-add :group 'Project :key "C-c p p" :description "counsel-projectile-switch-project")
  (cheatsheet-add :group 'Project :key "C-c p f" :description "counsel-projectile-find-file")
  (cheatsheet-add :group 'Project :key "C-c p d" :description "counsel-projectile-find-dir")
  (cheatsheet-add :group 'Project :key "C-c p b" :description "counsel-projectile-switch-to-buffer")
  (cheatsheet-add :group 'Project :key "C-c p i" :description "projectile-invalidate-cache")
  (cheatsheet-add :group 'Project :key "C-c p c" :description "projectile-compile-project")
  (cheatsheet-add :group 'Project :key "C-c p P" :description "projectile-test-project")
  (cheatsheet-add :group 'Project :key "C-c p t" :description "projectile-toggle-between-implementation-and-test")
  (cheatsheet-add :group 'Project :key "C-c p m" :description "projectile-commander")
  (cheatsheet-add :group 'Markdown :key "C-c C-a" :description "Add links")
  (cheatsheet-add :group 'Markdown :key "C-c C-i" :description "Add images")
  (cheatsheet-add :group 'Markdown :key "C-c C-a" :description "Add styles")
  (cheatsheet-add :group 'Markdown :key "C-c C-t" :description "Add headers")
  (cheatsheet-add :group 'Markdown :key "C-c -" :description "Add rules")
  (cheatsheet-add :group 'Markdown :key "C-c C-c" :description "Action menu")
  (cheatsheet-add :group 'Markdown :key "C-c C-c t" :description "Generate or update markdown TOC")
  (global-set-key (kbd "C-?") 'cheatsheet-show)
  (which-key-mode))

(provide 'completion-init)