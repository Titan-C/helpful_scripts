(require 'package)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

(eval-when-compile
    (require 'use-package)
    (setq use-package-verbose t
          use-package-always-ensure t))

(load-theme 'misterioso t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 465 t))
 ;; start fullscreen
(setq backup-directory-alist '(("~/.emacs.d/backups")))
(fset 'yes-or-no-p 'y-or-n-p)


;; Evil mode configuration
(unless (fboundp 'evil-leader-mode)
  (package-install 'evil-leader))
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
    "x" 'helm-M-x
    "e" 'helm-find-files
    "p" 'helm-projectile
    "t" 'magit-status
    "s" 'eshell
    "w" 'save-buffer
    "q" 'kill-buffer-and-window
    "oa" 'org-agenda
    "oc" 'org-capture
    "r" 'ace-jump-char-mode
    "c" 'ace-jump-word-mode
    "g" 'helm-mini)

(use-package ace-jump-mode
  :ensure t )

(define-key evil-normal-state-map "r" nil) ;; block replace
(define-key evil-motion-state-map "r" 'evil-backward-char) ;; back
(define-key evil-insert-state-map "\C-l" 'evil-delete-backward-char)
(define-key evil-insert-state-map "\C-r" 'evil-delete-backward-word)

(define-key evil-motion-state-map "n" 'evil-next-line) ;; next line
(define-key evil-motion-state-map "l" 'evil-search-next) ;; next look up
(define-key evil-motion-state-map "L" 'evil-search-previous)
(define-key evil-motion-state-map "t" 'evil-previous-line) ;; top back up
(define-key evil-normal-state-map "T" 'evil-join) ;; line together

(define-key evil-normal-state-map "s" nil) ;; remove substitute
(define-key evil-motion-state-map "s" 'evil-forward-char)  ;; moves right

(define-key evil-normal-state-map "h" 'evil-replace)
(define-key evil-visual-state-map "h" 'evil-replace) ;; because it seems to respect old motion
(define-key evil-motion-state-map "j" 'evil-find-char-to)
(define-key evil-motion-state-map "J" 'evil-find-char-to-backward)
(define-key evil-normal-state-map "k" 'redo)
(define-key evil-motion-state-map "k" nil) ;; to block old motion

;; end and begining of lines
(define-key evil-motion-state-map "-" 'evil-end-of-line)
(define-key evil-motion-state-map "0" 'evil-beginning-of-line)

(define-key evil-normal-state-map (kbd "C-r") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-n") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-t") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-s") 'evil-window-right)

(use-package powerline-evil
  :config
  (powerline-default-theme))

(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x g" . helm-mini))
  :config
  (require 'helm-config)
  (helm-mode 1))
(use-package helm-projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package auto-complete
  :init
  (ac-config-default)
  (setq ac-auto-show-menu 0.2))
;; Org mode setup

(setq org-directory "~/Dropbox/org"
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-mobile-inbox-for-pull "~/Dropbox/org/mobilecaptures.org")
(evil-leader/set-key-for-mode 'org-mode
    "ot"  'outline-previous-visible-heading
    "on"  'outline-next-visible-heading
    "oo" 'org-insert-heading
    "os" 'org-sort-list
    "ot" 'org-todo)

(add-hook 'org-mode-hook 'turn-on-flyspell)
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)" "DEFERRED(f@)")))
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/Dropbox/org/notes.org" "Tasks")
	 "* TODO %?\n  %U\n  %i\n  %a" :clock-in t :clock-resume t)
	("j" "Journal Entry" entry (file+datetree "~/Dropbox/org/journal.org")
         "* %(format-time-string \"%H:%M\") %?\n  %i\n  %a" :clock-in t :clock-resume t)
	("l" "Lab Journal Entry" entry (file+datetree "~/Dropbox/org/PHD_Journal.org")
         "* %(format-time-string \"%H:%M\") %?\n  %i\n  %a" :clock-in t :clock-resume t)
        ("e" "Event" entry (file "~/Dropbox/org/schedule.org")
	 "* %?\n  %^T\n  %i\n  %a" :clock-in t :clock-resume t)))

(use-package org
  :bind (("\C-cl" . org-store-link)
	 ("\C-cb" . org-iswitchb)
         ("\C-ca" . org-agenda)
         ("\C-cc" . org-capture))
  :init
  (setq org-agenda-start-on-weekday 0)
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (setq org-agenda-files (list "~/Dropbox/org/schedule.org"
			       "~/Dropbox/org/journal.org"
                               "~/Dropbox/org/todo.org")))

(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 ("~/Dropbox/org/journal.org" :maxlevel . 3)
                                 ("~/Dropbox/org/todo.org" :maxlevel . 2))))
(setq org-refile-use-outline-path nil)

;; Previewing latex fragments in org mode
(setq org-latex-create-formula-image-program 'imagemagick) ;; Recommended to use imagemagick
(use-package ob-ipython)
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(setq org-src-fontify-natively t);; sintax highligting of codeblock in org

;; dired
;; modify dired keys
(progn
  (require 'dired )
  (define-key dired-mode-map "t" 'dired-previous-line)
  (define-key dired-mode-map "p" 'dired-toggle-marks)
  )




;; Editing assintants
(use-package flycheck
  :config
  (flycheck-add-next-checker 'python-flake8 'python-pylint)
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))

(define-key evil-motion-state-map "gp" 'flycheck-previous-error)
(define-key evil-motion-state-map "gl" 'flycheck-next-error)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package relative-line-numbers
  :config
  (global-relative-line-numbers-mode)
  (setq relative-line-numbers-motion-function 'forward-visible-line))


(use-package yasnippet
  :config (yas-global-mode t))

(use-package magit
  :config
  (define-key magit-mode-map "t" 'magit-section-backward)
  (define-key magit-mode-map "\M-t" 'magit-section-backward-sibling)
  (define-key magit-mode-map "p" 'magit-tag-popup)
  (add-hook 'git-commit-mode-hook 'flyspell-mode)
  (add-hook 'git-commit-mode-hook 'evil-insert-state))
(use-package magit-gh-pulls
  :init
  (add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls))

;; Languages configs
;; Python
(setq python-shell-interpreter "ipython")
(use-package jedi
  :config
  (add-hook 'python-mode-hook 'flyspell-prog-mode)
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

(use-package cython-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Latex
(use-package tex-site
  :ensure auctex
  :config
  (setq LaTeX-command "latex -shell-escape"))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; entertainment
(use-package twittering-mode
  :config
  (setq twittering-use-master-password t)
  (setq twittering-icon-mode t)
  (setq twittering-use-icon-storage t))

(use-package ssh
  :ensure t)

(use-package ox-reveal
  :config
  (setq org-reveal-root "file:///home/oscar/dev/reveal.js"))
