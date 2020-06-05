;;; Begin initialization

;;; Avoid loading shipped org. It assumes I have a recent install in elpa folder for this to work
(setq load-path (remove "/snap/emacs/current/usr/share/emacs/26.3/lisp/org" load-path))

(setq gc-cons-threshold 100000000)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
;;(add-to-list 'default-frame-alist '(alpha . (95 . 70)))
(setq tls-checktrust t)
(setq gnutls-verify-error t)
;Declare the package archives to the emacs package manager.
(require 'package)
(setq package-archives '(("melpast" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))

;;(erc-tls :server "irc.oftc.net" :port "6697" :nick "titan-c")
;;(erc-tls :server "chat.freenode.net" :port "6697" :nick (car (auth-source-user-and-password "chat.freenode.net")) :password  (cadr (auth-source-user-and-password "chat.freenode.net")))
;;(erc-tls :server "irc.mozilla.org" :port "6697" :nick "titan-c")

;;(erc-tls :server "irc.gitter.im" :port 6697 :password (cadr (auth-source-user-and-password "irc.gitter.im")) :nick (car (auth-source-user-and-password "irc.gitter.im")))
