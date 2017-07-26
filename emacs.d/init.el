;;; Begin initialization
(setq gc-cons-threshold 100000000)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(add-to-list 'default-frame-alist '(alpha . (95 . 70)))
(setq tls-checktrust t)
(setq gnutls-verify-error t)

(require 'package)
(setq package-archives '(("melpast" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

(eval-when-compile
    (require 'use-package)
    (setq use-package-verbose t
          use-package-always-ensure t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c86f868347919095aa44d2a6129dd714cbcf8feaa88ba954f636295b14ceff8f" "9ff70d8009ce8da6fa204e803022f8160c700503b6029a8d8880a7a78c5ff2e5" default)))
 '(package-selected-packages
   (quote
    (org-pdfview helm-notmuch notmuch helm-org-rifle racer org-ref helm-bibtex key-chord hydra org-edit-latex evil-surround yaml-mode which-key use-package twittering-mode swiper sphinx-doc spaceline smartparens scss-mode relative-line-numbers rainbow-delimiters pythonic py-autopep8 ox-reveal org-plus-contrib org-gcal org-bullets multi-term material-theme markdown-mode magit-gh-pulls lua-mode langtool htmlize helm-pydoc helm-projectile helm-ag flycheck-rust flycheck-clojure exec-path-from-shell evil-leader eshell-git-prompt emms elpy elfeed-org ein dockerfile-mode cython-mode company-math command-log-mode cmake-mode cargo bbdb auto-complete auctex ace-window))))

;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))

(defun auth-source-user-and-password (host &optional user)
  (let* ((auth-info (car
                     (if user
                         (auth-source-search
                          :host host
                          :user user
                          :max 1
                          :require '(:user :secret)
                          :create nil)
                       (auth-source-search
                        :host host
                        :max 1
                        :require '(:user :secret)
                        :create nil))))
         (user (plist-get auth-info :user))
         (password (plist-get auth-info :secret)))
    (when (functionp password)
      (setq password (funcall password)))
    (list user password auth-info)))

;;(erc-tls :server "irc.oftc.net" :port "6697" :nick "titan-c")
;;(erc-tls :server "chat.freenode.net" :port "6697" :nick (car (auth-source-user-and-password "chat.freenode.net")) :password  (cadr (auth-source-user-and-password "chat.freenode.net")))
;;(erc-tls :server "irc.mozilla.org" :port "6697" :nick "titan-c")

;;(erc-tls :server "irc.gitter.im" :port 6697 :password (cadr (auth-source-user-and-password "irc.gitter.im")) :nick (car (auth-source-user-and-password "irc.gitter.im")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
