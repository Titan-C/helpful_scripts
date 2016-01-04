;; GNUS configuration
(require 'nnir)

(setq gnus-select-method
      '(nnimap "gmail"
           (nnimap-address "imap.googlemail.com")  ; it could also be imap.googlemail.com if that's your server.
           (nnimap-server-port "imaps")
	   (nnir-search-engine imap)
           (nnimap-stream ssl)))

;; Archive outgoing email in Sent folder on imap.googlemail.com:
(setq gnus-message-archive-method '(nnimap "imap.googlemail.com")
    gnus-message-archive-group "[Gmail]/Sent Mail")

(add-to-list 'gnus-secondary-select-methods
    '(nnimap "U-psud"
	(nnimap-address "zimbra.u-psud.fr")
	(nnimap-server-port "imaps")
	(nnir-search-engine imap)
	(nnimap-stream ssl)))
(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number
        (not gnus-thread-sort-by-date))
      gnus-article-sort-functions
      '(gnus-article-sort-by-number
	gnus-article-sort-by-date))

(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
