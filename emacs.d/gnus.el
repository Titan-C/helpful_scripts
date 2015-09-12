;; GNUS configuration
(setq user-mail-address "najera.oscar@gmail.com"
      user-full-name    "Óscar Nájera")

(require 'nnir)
(setq gnus-fetch-old-headers t)

(setq gnus-select-method
      '(nnimap "gmail"
           (nnimap-address "imap.googlemail.com")  ; it could also be imap.googlemail.com if that's your server.
           (nnimap-server-port "imaps")
	   (nnir-search-engine imap)
           (nnimap-stream ssl)))

(add-to-list 'gnus-secondary-select-methods
    '(nnimap "U-psud"
	(nnimap-address "zimbra.u-psud.fr")
	(nnimap-server-port "imaps")
	(nnir-search-engine imap)
	(nnimap-stream ssl)))

(setq smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
;;; bbdb
(require 'bbdb)
(setq
 bbdb-file "~/Dropbox/bbdb"
 bbdb-offer-save 'auto
 bbdb-notice-auto-save-file t
 bbdb-expand-mail-aliases t
 bbdb-canonicalize-redundant-nets-p t
 bbdb-always-add-addresses t
 bbdb-complete-name-allow-cycling t
 )

;; linebreak in message editing
(defun my-message-mode-setup ()
(setq fill-column 72)
(turn-on-auto-fill))
(add-hook 'message-mode-hook 'my-message-mode-setup)
