(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)

(load-theme 'misterioso t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.googlemail.com")
 '(smtpmail-smtp-service 465))
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

(require 'powerline)
(powerline-default-theme)
(require 'powerline-evil)

(require 'helm-config)
;(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)


;; Org mode setup
(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
(require 'org-journal)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-journal-dir "~/Dropbox/org/journal/")
(add-hook 'org-journal-mode-hook 'auto-fill-mode)
(setq org-agenda-files (list org-journal-dir
			     "~/Dropbox/org/todo.org"))
(setq org-agenda-file-regexp "\\`[^.].*\\.org'\\|[0-9]+")
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(require 'org-gcal)
;(setq org-gcal-client-id "127248754961-ipgp675sf8q6cepjkvlc5s1bh672bko8.apps.googleusercontent.com"
;      org-gcal-client-secret  "DF3h_ZXgujvE0a26ybscCDXz"
;      org-gcal-file-alist '("najera.oscar@gmail.com" . "~/Dropbox/org/schedule.org"))
;; Previewing latex fragments in org mode
(setq org-latex-create-formula-image-program 'imagemagick) ;; Recommended to use imagemagick
(require 'ob-ipython)
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(setq org-src-fontify-natively t);; sintax highligting of codeblock in org


;; Editing assintants
(global-relative-line-numbers-mode)
;(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
;(add-hook 'prog-mode-hook 'line-number-mode t)
;(add-hook 'prog-mode-hook 'column-number-mode t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'yasnippet)
(yas-global-mode t)

;; Languages configs
;; Python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; Latex
(load "auctex.el" nil t t)
(setq LaTeX-command "latex -shell-escape")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
