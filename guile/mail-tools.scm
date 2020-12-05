(define-module (mail-tools)
  #:use-module (ffi notmuch)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 regex)
  #:use-module (srfi srfi-1)
  #:use-module (system ffi-help-rt)
  #:use-module (system foreign)
  #:export (rename-higher
            get-uidvalidity
            get-folder-uidvalidity
            new-path
            with-new
            nm-open-database
            nm-query-db
            nm-result-messages
            nm-header
            nm-count-messages
            nm-apply-tags
            nm-iter))

(define (rename-higher name limit)
  (let ((mat (string-match ",U=[0-9]+" name)))
    (if (and mat (< limit (string->number (substring (match:substring mat) 3))))
        (string-append (match:prefix mat) (match:suffix mat))
        name)))

(define (get-uidvalidity port)
  (read-line port)
  (string->number (read-line port)))

(define (get-folder-uidvalidity folder)
  (call-with-input-file (string-append folder "/.uidvalidity") get-uidvalidity))

(define (new-path path destination)
  (let ((filename (basename path))
        (submaildir (basename (dirname path))))
    (string-join (list destination submaildir filename)
                 file-name-separator-string)))

(define (with-new rule new)
  (list
   (if new (string-append (car rule) " -new") (car rule))
   (if new
       (if (string=? (cadr rule) "*")
           "tag:new"
           (simple-format #f "(~a) and ~a" (cadr rule) "tag:new"))
       (cadr rule))))

;; NOTMUCH interface
(define (nm-open-database path mode)
  (let ((ffi-db (make-notmuch_database_t*)))
    (notmuch_database_open (string->pointer path) mode (pointer-to ffi-db))
    ffi-db))

(define (nm-query-db db str)
  (let ((query (notmuch_query_create db (string->pointer str))))
    (for-each (lambda (tag)
                (notmuch_query_add_tag_exclude query (string->pointer tag)))
              (list "deleted" "spam"))
    query))

(define (nm-result-messages query)
  (let ((messages (make-notmuch_messages_t*)))
    (notmuch_query_search_messages query (pointer-to messages))
    messages))

(define (nm-header message label)
  (pointer->string (notmuch_message_get_header message (string->pointer label))))

(define (nm-count-messages query)
  (let ((counter (make-int32)))
    (notmuch_query_count_messages query (pointer-to counter))
    (fh-object-ref counter)))

(eval-when (expand load eval)
  (define (stx->str stx) (symbol->string (syntax->datum stx)))
  (define (singular stx) (string-drop-right (stx->str stx) 1))
  (define (nm-symbols tmpl-id . args)
    (datum->syntax
     tmpl-id
     (string->symbol
      (apply string-append
             (map (lambda (ss) (if (string? ss) ss (stx->str ss))) args))))))

(define-syntax nm-iter
  (lambda (x)
    (syntax-case x ()
      ((_ type query proc)
       (with-syntax ((valid? (nm-symbols #'type "notmuch_" #'type "_valid"))
                     (destroy (nm-symbols #'type "notmuch_" #'type "_destroy"))
                     (get (nm-symbols #'type "notmuch_" #'type "_get"))
                     (next (nm-symbols #'type "notmuch_" #'type "_move_to_next"))
                     (item-destroy (nm-symbols #'type "notmuch_" (singular #'type) "_destroy")))
         #'(let ((obj query))
             (let loop ((item (get obj))
                        (acc '()))
               (if (= 0 (valid? obj))
                   (begin
                     (destroy obj)
                     acc)
                   (let ((result (proc item)))
                     (when (defined? (quote item-destroy))
                       (item-destroy item))
                     (next obj)
                     (loop (get obj) (cons result acc)))))))))))

(define (nm-apply-tags message tags)
  (let loop ((rest (string-tokenize tags)))
    (unless (null-list? rest)
      (let ((tag (string->pointer (substring (car rest) 1))))
        (if (string-prefix? "-" (car rest))
            (notmuch_message_remove_tag message tag)
            (notmuch_message_add_tag message tag)))
      (loop (cdr rest)))))
