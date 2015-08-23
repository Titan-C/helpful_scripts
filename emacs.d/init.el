(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)

(load-theme 'misterioso t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'yasnippet)
(yas-global-mode t)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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

(require 'powerline)
(powerline-default-theme)
(require 'powerline-evil)
(require 'helm-config)
;(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'org-gcal)
;(setq org-gcal-client-id "127248754961-ipgp675sf8q6cepjkvlc5s1bh672bko8.apps.googleusercontent.com"
;      org-gcal-client-secret  "DF3h_ZXgujvE0a26ybscCDXz"
;      org-gcal-file-alist '("najera.oscar@gmail.com" . "~/Dropbox/vimwiki/schedule.org"))
;; Previewing latex fragments in org mode
(setq org-latex-create-formula-image-program 'imagemagick) ;; Recommended to use imagemagick

(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)
(setq LaTeX-command "latex -shell-escape")
(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;;(require 'ein)
(require 'ob-ipython)
;;(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(setq org-src-fontify-natively t)
(setq org-journal-dir "~/Dropbox/vimwiki/journal/")

(global-relative-line-numbers-mode)
;(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
;(add-hook 'prog-mode-hook 'line-number-mode t)
;(add-hook 'prog-mode-hook 'column-number-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
