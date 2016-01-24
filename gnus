;;-*- mode: emacs-lisp; -*-
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

(define-key gnus-group-mode-map "p" 'gnus-topic-mode)
(define-key gnus-group-mode-map "P" 'gnus-group-topic-map)
(define-key gnus-group-mode-map "t" 'gnus-group-prev-unread-group)
(define-key gnus-group-mode-map "T" 'gnus-group-prev-group)

(define-key gnus-summary-mode-map "T" 'gnus-summary-prev-article)
(define-key gnus-summary-mode-map "t" 'gnus-summary-prev-unread-article)
(define-key gnus-summary-mode-map "p" 'gnus-summary-toggle-header)
(define-key gnus-summary-mode-map "P" 'gnus-summary-thread-map)
