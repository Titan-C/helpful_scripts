;;; Begin initialization
(setq gc-cons-threshold 100000000)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(add-to-list 'default-frame-alist '(alpha . (95 . 70)))
(setq tls-checktrust t)
(setq gnutls-verify-error t)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
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
 )

;;; Load the config
(org-babel-load-file (concat user-emacs-directory "config.org"))
