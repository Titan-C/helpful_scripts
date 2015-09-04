(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

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


;; Evil mode configuration
(unless (fboundp 'evil-leader-mode)
  (package-install 'evil-leader))
(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
    "e" 'helm-find-files
    "p" 'helm-projectile
    "g" 'magit-status
    "bd" 'kill-this-buffer)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(use-package powerline-evil
  :config
  (powerline-default-theme))

(use-package helm
  :config
  (require 'helm-config)
  (helm-mode 1))
(use-package helm-projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))


;; Org mode setup
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(use-package org-journal
;;(require 'org-journal)
  :bind (("\C-cl" . org-store-link)
	 ("\C-cb" . org-iswitchb)
         ("\C-ca" . org-agenda)
         ("\C-cc" . org-capture))
  :init
  (setq org-journal-dir "~/Dropbox/org/journal/")
  (add-hook 'org-journal-mode-hook 'auto-fill-mode)
  (setq org-agenda-files (list org-journal-dir
                               "~/Dropbox/org/schedule.org"
                               "~/Dropbox/org/todo.org"))
  (setq org-agenda-file-regexp "\\`[^.].*\\.org'\\|[0-9]+"))

(use-package org-gcal
  :init (setq org-gcal-client-id "127248754961-ipgp675sf8q6cepjkvlc5s1bh672bko8.apps.googleusercontent.com"
      org-gcal-client-secret  "DF3h_ZXgujvE0a26ybscCDXz"
      org-gcal-file-alist '(("najera.oscar@gmail.com" . "~/Dropbox/org/schedule.org"))))
;; Previewing latex fragments in org mode
(setq org-latex-create-formula-image-program 'imagemagick) ;; Recommended to use imagemagick
(use-package ob-ipython)
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(setq org-src-fontify-natively t);; sintax highligting of codeblock in org


;; Editing assintants
(use-package flycheck
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))
(define-key evil-motion-state-map "gp" 'flycheck-previous-error)
(define-key evil-motion-state-map "gn" 'flycheck-next-error)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package relative-line-numbers
  :config (global-relative-line-numbers-mode))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(use-package yasnippet
  :config (yas-global-mode t))

;; Languages configs
;; Python
(setq python-shell-interpreter "ipython")
(use-package jedi
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t))

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