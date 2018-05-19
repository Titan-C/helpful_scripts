;;; Begin initialization
(setq gc-cons-threshold 100000000)
(scroll-bar-mode 0)
(tool-bar-mode 0)
;;(add-to-list 'default-frame-alist '(alpha . (95 . 70)))
(setq tls-checktrust t)
(setq gnutls-verify-error t)

(require 'package)
(setq package-archives '(;;("melpast" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
   (package-refresh-contents)
   (package-install 'use-package))

(eval-when-compile
    (require 'use-package)
    (setq use-package-verbose t
          use-package-always-ensure t))

;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))

;;(erc-tls :server "irc.oftc.net" :port "6697" :nick "titan-c")
;;(erc-tls :server "chat.freenode.net" :port "6697" :nick (car (auth-source-user-and-password "chat.freenode.net")) :password  (cadr (auth-source-user-and-password "chat.freenode.net")))
;;(erc-tls :server "irc.mozilla.org" :port "6697" :nick "titan-c")

;;(erc-tls :server "irc.gitter.im" :port 6697 :password (cadr (auth-source-user-and-password "irc.gitter.im")) :nick (car (auth-source-user-and-password "irc.gitter.im")))
