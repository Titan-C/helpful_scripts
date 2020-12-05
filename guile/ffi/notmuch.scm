;; generated with `guild compile-ffi ffi/notmuch.ffi'

(define-module (ffi notmuch)
  #:use-module (system ffi-help-rt)
  #:use-module ((system foreign) #:prefix ffi:)
  #:use-module (bytestructures guile))

(define ffi-notmuch-llibs
  (delay (list (dynamic-link "libnotmuch"))))

(cond-expand
  (guile-2.2)
  (guile-2
    (define intptr_t long)
    (define uintptr_t unsigned-long)))


;; typedef int notmuch_bool_t;
(define-public notmuch_bool_t-desc int)

;; typedef enum _notmuch_status {
;;   NOTMUCH_STATUS_SUCCESS = 0,
;;   NOTMUCH_STATUS_OUT_OF_MEMORY,
;;   NOTMUCH_STATUS_READ_ONLY_DATABASE,
;;   NOTMUCH_STATUS_XAPIAN_EXCEPTION,
;;   NOTMUCH_STATUS_FILE_ERROR,
;;   NOTMUCH_STATUS_FILE_NOT_EMAIL,
;;   NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID,
;;   NOTMUCH_STATUS_NULL_POINTER,
;;   NOTMUCH_STATUS_TAG_TOO_LONG,
;;   NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW,
;;   NOTMUCH_STATUS_UNBALANCED_ATOMIC,
;;   NOTMUCH_STATUS_UNSUPPORTED_OPERATION,
;;   NOTMUCH_STATUS_UPGRADE_REQUIRED,
;;   NOTMUCH_STATUS_PATH_ERROR,
;;   NOTMUCH_STATUS_IGNORED,
;;   NOTMUCH_STATUS_ILLEGAL_ARGUMENT,
;;   NOTMUCH_STATUS_MALFORMED_CRYPTO_PROTOCOL,
;;   NOTMUCH_STATUS_FAILED_CRYPTO_CONTEXT_CREATION,
;;   NOTMUCH_STATUS_UNKNOWN_CRYPTO_PROTOCOL,
;;   NOTMUCH_STATUS_LAST_STATUS,
;; } notmuch_status_t;
(define notmuch_status_t-enum-nvl
  '((NOTMUCH_STATUS_SUCCESS . 0)
    (NOTMUCH_STATUS_OUT_OF_MEMORY . 1)
    (NOTMUCH_STATUS_READ_ONLY_DATABASE . 2)
    (NOTMUCH_STATUS_XAPIAN_EXCEPTION . 3)
    (NOTMUCH_STATUS_FILE_ERROR . 4)
    (NOTMUCH_STATUS_FILE_NOT_EMAIL . 5)
    (NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID . 6)
    (NOTMUCH_STATUS_NULL_POINTER . 7)
    (NOTMUCH_STATUS_TAG_TOO_LONG . 8)
    (NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW . 9)
    (NOTMUCH_STATUS_UNBALANCED_ATOMIC . 10)
    (NOTMUCH_STATUS_UNSUPPORTED_OPERATION . 11)
    (NOTMUCH_STATUS_UPGRADE_REQUIRED . 12)
    (NOTMUCH_STATUS_PATH_ERROR . 13)
    (NOTMUCH_STATUS_IGNORED . 14)
    (NOTMUCH_STATUS_ILLEGAL_ARGUMENT . 15)
    (NOTMUCH_STATUS_MALFORMED_CRYPTO_PROTOCOL . 16)
    (NOTMUCH_STATUS_FAILED_CRYPTO_CONTEXT_CREATION
      .
      17)
    (NOTMUCH_STATUS_UNKNOWN_CRYPTO_PROTOCOL . 18)
    (NOTMUCH_STATUS_LAST_STATUS . 19))
  )
(define notmuch_status_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_status_t-enum-nvl))
(define-public (unwrap-notmuch_status_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_status_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_status_t v)
  (assq-ref notmuch_status_t-enum-vnl v))
(define-public unwrap-enum-_notmuch_status unwrap-notmuch_status_t)
(define-public wrap-enum-_notmuch_status wrap-notmuch_status_t)

;; enum _notmuch_status {
;;   NOTMUCH_STATUS_SUCCESS = 0,
;;   NOTMUCH_STATUS_OUT_OF_MEMORY,
;;   NOTMUCH_STATUS_READ_ONLY_DATABASE,
;;   NOTMUCH_STATUS_XAPIAN_EXCEPTION,
;;   NOTMUCH_STATUS_FILE_ERROR,
;;   NOTMUCH_STATUS_FILE_NOT_EMAIL,
;;   NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID,
;;   NOTMUCH_STATUS_NULL_POINTER,
;;   NOTMUCH_STATUS_TAG_TOO_LONG,
;;   NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW,
;;   NOTMUCH_STATUS_UNBALANCED_ATOMIC,
;;   NOTMUCH_STATUS_UNSUPPORTED_OPERATION,
;;   NOTMUCH_STATUS_UPGRADE_REQUIRED,
;;   NOTMUCH_STATUS_PATH_ERROR,
;;   NOTMUCH_STATUS_IGNORED,
;;   NOTMUCH_STATUS_ILLEGAL_ARGUMENT,
;;   NOTMUCH_STATUS_MALFORMED_CRYPTO_PROTOCOL,
;;   NOTMUCH_STATUS_FAILED_CRYPTO_CONTEXT_CREATION,
;;   NOTMUCH_STATUS_UNKNOWN_CRYPTO_PROTOCOL,
;;   NOTMUCH_STATUS_LAST_STATUS,
;; };

;; const char *notmuch_status_to_string(notmuch_status_t status);
(define notmuch_status_to_string
  (let ((~notmuch_status_to_string
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_status_to_string"
                   (list ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (status)
      (let ((~status (unwrap-notmuch_status_t status)))
        ((force ~notmuch_status_to_string) ~status)))))
(export notmuch_status_to_string)

;; typedef struct _notmuch_database notmuch_database_t;
(define-public notmuch_database_t-desc 'void)
(define-fh-type-alias notmuch_database_t fh-void)
(define-public notmuch_database_t? fh-void?)
(define-public make-notmuch_database_t make-fh-void)
(define-public notmuch_database_t*-desc (fh:pointer notmuch_database_t-desc))
(define-fh-pointer-type notmuch_database_t* notmuch_database_t*-desc 
 notmuch_database_t*? make-notmuch_database_t*)
(export notmuch_database_t* notmuch_database_t*? make-notmuch_database_t*)

;; typedef struct _notmuch_query notmuch_query_t;
(define-public notmuch_query_t-desc 'void)
(define-fh-type-alias notmuch_query_t fh-void)
(define-public notmuch_query_t? fh-void?)
(define-public make-notmuch_query_t make-fh-void)
(define-public notmuch_query_t*-desc (fh:pointer notmuch_query_t-desc))
(define-fh-pointer-type notmuch_query_t* notmuch_query_t*-desc 
 notmuch_query_t*? make-notmuch_query_t*)
(export notmuch_query_t* notmuch_query_t*? make-notmuch_query_t*)

;; typedef struct _notmuch_threads notmuch_threads_t;
(define-public notmuch_threads_t-desc 'void)
(define-fh-type-alias notmuch_threads_t fh-void)
(define-public notmuch_threads_t? fh-void?)
(define-public make-notmuch_threads_t make-fh-void)
(define-public notmuch_threads_t*-desc (fh:pointer notmuch_threads_t-desc))
(define-fh-pointer-type notmuch_threads_t* notmuch_threads_t*-desc 
 notmuch_threads_t*? make-notmuch_threads_t*)
(export notmuch_threads_t* notmuch_threads_t*? make-notmuch_threads_t*)

;; typedef struct _notmuch_thread notmuch_thread_t;
(define-public notmuch_thread_t-desc 'void)
(define-fh-type-alias notmuch_thread_t fh-void)
(define-public notmuch_thread_t? fh-void?)
(define-public make-notmuch_thread_t make-fh-void)
(define-public notmuch_thread_t*-desc (fh:pointer notmuch_thread_t-desc))
(define-fh-pointer-type notmuch_thread_t* notmuch_thread_t*-desc 
 notmuch_thread_t*? make-notmuch_thread_t*)
(export notmuch_thread_t* notmuch_thread_t*? make-notmuch_thread_t*)

;; typedef struct _notmuch_messages notmuch_messages_t;
(define-public notmuch_messages_t-desc 'void)
(define-fh-type-alias notmuch_messages_t fh-void)
(define-public notmuch_messages_t? fh-void?)
(define-public make-notmuch_messages_t make-fh-void)
(define-public notmuch_messages_t*-desc (fh:pointer notmuch_messages_t-desc))
(define-fh-pointer-type notmuch_messages_t* notmuch_messages_t*-desc 
 notmuch_messages_t*? make-notmuch_messages_t*)
(export notmuch_messages_t* notmuch_messages_t*? make-notmuch_messages_t*)

;; typedef struct _notmuch_message notmuch_message_t;
(define-public notmuch_message_t-desc 'void)
(define-fh-type-alias notmuch_message_t fh-void)
(define-public notmuch_message_t? fh-void?)
(define-public make-notmuch_message_t make-fh-void)
(define-public notmuch_message_t*-desc (fh:pointer notmuch_message_t-desc))
(define-fh-pointer-type notmuch_message_t* notmuch_message_t*-desc 
 notmuch_message_t*? make-notmuch_message_t*)
(export notmuch_message_t* notmuch_message_t*? make-notmuch_message_t*)

;; typedef struct _notmuch_tags notmuch_tags_t;
(define-public notmuch_tags_t-desc 'void)
(define-fh-type-alias notmuch_tags_t fh-void)
(define-public notmuch_tags_t? fh-void?)
(define-public make-notmuch_tags_t make-fh-void)
(define-public notmuch_tags_t*-desc (fh:pointer notmuch_tags_t-desc))
(define-fh-pointer-type notmuch_tags_t* notmuch_tags_t*-desc notmuch_tags_t*? 
 make-notmuch_tags_t*)
(export notmuch_tags_t* notmuch_tags_t*? make-notmuch_tags_t*)

;; typedef struct _notmuch_directory notmuch_directory_t;
(define-public notmuch_directory_t-desc 'void)
(define-fh-type-alias notmuch_directory_t fh-void)
(define-public notmuch_directory_t? fh-void?)
(define-public make-notmuch_directory_t make-fh-void)
(define-public notmuch_directory_t*-desc (fh:pointer notmuch_directory_t-desc))
(define-fh-pointer-type notmuch_directory_t* notmuch_directory_t*-desc 
 notmuch_directory_t*? make-notmuch_directory_t*)
(export notmuch_directory_t* notmuch_directory_t*? make-notmuch_directory_t*)

;; typedef struct _notmuch_filenames notmuch_filenames_t;
(define-public notmuch_filenames_t-desc 'void)
(define-fh-type-alias notmuch_filenames_t fh-void)
(define-public notmuch_filenames_t? fh-void?)
(define-public make-notmuch_filenames_t make-fh-void)
(define-public notmuch_filenames_t*-desc (fh:pointer notmuch_filenames_t-desc))
(define-fh-pointer-type notmuch_filenames_t* notmuch_filenames_t*-desc 
 notmuch_filenames_t*? make-notmuch_filenames_t*)
(export notmuch_filenames_t* notmuch_filenames_t*? make-notmuch_filenames_t*)

;; typedef struct _notmuch_config_list notmuch_config_list_t;
(define-public notmuch_config_list_t-desc 'void)
(define-fh-type-alias notmuch_config_list_t fh-void)
(define-public notmuch_config_list_t? fh-void?)
(define-public make-notmuch_config_list_t make-fh-void)
(define-public notmuch_config_list_t*-desc (fh:pointer notmuch_config_list_t-desc))
(define-fh-pointer-type notmuch_config_list_t* notmuch_config_list_t*-desc 
 notmuch_config_list_t*? make-notmuch_config_list_t*)
(export notmuch_config_list_t* notmuch_config_list_t*? 
 make-notmuch_config_list_t*)

;; typedef struct _notmuch_indexopts notmuch_indexopts_t;
(define-public notmuch_indexopts_t-desc 'void)
(define-fh-type-alias notmuch_indexopts_t fh-void)
(define-public notmuch_indexopts_t? fh-void?)
(define-public make-notmuch_indexopts_t make-fh-void)
(define-public notmuch_indexopts_t*-desc (fh:pointer notmuch_indexopts_t-desc))
(define-fh-pointer-type notmuch_indexopts_t* notmuch_indexopts_t*-desc 
 notmuch_indexopts_t*? make-notmuch_indexopts_t*)
(export notmuch_indexopts_t* notmuch_indexopts_t*? make-notmuch_indexopts_t*)

;; notmuch_status_t notmuch_database_create(const char *path, 
;;     notmuch_database_t **database);
(define notmuch_database_create
  (let ((~notmuch_database_create
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_create"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (path database)
      (let ((~path (unwrap~pointer path))
            (~database (unwrap~pointer database)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_create)
           ~path
           ~database))))))
(export notmuch_database_create)

;; notmuch_status_t notmuch_database_create_verbose(const char *path, 
;;     notmuch_database_t **database, char **error_message);
(define notmuch_database_create_verbose
  (let ((~notmuch_database_create_verbose
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_create_verbose"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (path database error_message)
      (let ((~path (unwrap~pointer path))
            (~database (unwrap~pointer database))
            (~error_message (unwrap~pointer error_message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_create_verbose)
           ~path
           ~database
           ~error_message))))))
(export notmuch_database_create_verbose)

;; typedef enum {
;;   NOTMUCH_DATABASE_MODE_READ_ONLY = 0,
;;   NOTMUCH_DATABASE_MODE_READ_WRITE,
;; } notmuch_database_mode_t;
(define notmuch_database_mode_t-enum-nvl
  '((NOTMUCH_DATABASE_MODE_READ_ONLY . 0)
    (NOTMUCH_DATABASE_MODE_READ_WRITE . 1))
  )
(define notmuch_database_mode_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_database_mode_t-enum-nvl))
(define-public (unwrap-notmuch_database_mode_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_database_mode_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_database_mode_t v)
  (assq-ref notmuch_database_mode_t-enum-vnl v))

;; notmuch_status_t notmuch_database_open(const char *path, 
;;     notmuch_database_mode_t mode, notmuch_database_t **database);
(define notmuch_database_open
  (let ((~notmuch_database_open
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_open"
                   (list ffi-void* ffi:int ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (path mode database)
      (let ((~path (unwrap~pointer path))
            (~mode (unwrap-notmuch_database_mode_t mode))
            (~database (unwrap~pointer database)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_open)
           ~path
           ~mode
           ~database))))))
(export notmuch_database_open)

;; notmuch_status_t notmuch_database_open_verbose(const char *path, 
;;     notmuch_database_mode_t mode, notmuch_database_t **database, char **
;;     error_message);
(define notmuch_database_open_verbose
  (let ((~notmuch_database_open_verbose
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_open_verbose"
                   (list ffi-void* ffi:int ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (path mode database error_message)
      (let ((~path (unwrap~pointer path))
            (~mode (unwrap-notmuch_database_mode_t mode))
            (~database (unwrap~pointer database))
            (~error_message (unwrap~pointer error_message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_open_verbose)
           ~path
           ~mode
           ~database
           ~error_message))))))
(export notmuch_database_open_verbose)

;; const char *notmuch_database_status_string(const notmuch_database_t *notmuch
;;     );
(define notmuch_database_status_string
  (let ((~notmuch_database_status_string
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_database_status_string"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (notmuch)
      (let ((~notmuch
              ((fht-unwrap notmuch_database_t*) notmuch)))
        ((force ~notmuch_database_status_string)
         ~notmuch)))))
(export notmuch_database_status_string)

;; notmuch_status_t notmuch_database_close(notmuch_database_t *database);
(define notmuch_database_close
  (let ((~notmuch_database_close
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_close"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_close) ~database))))))
(export notmuch_database_close)

;; typedef void (*notmuch_compact_status_cb_t)(const char *message, void *
;;     closure);
(define-public notmuch_compact_status_cb_t-desc
  (fh:pointer
    (delay (fh:function
             'void
             (list (fh:pointer int8) (fh:pointer 'void)))))
  )
(define-fh-function*-type
  notmuch_compact_status_cb_t
  notmuch_compact_status_cb_t-desc
  notmuch_compact_status_cb_t?
  make-notmuch_compact_status_cb_t)
(export notmuch_compact_status_cb_t notmuch_compact_status_cb_t? 
 make-notmuch_compact_status_cb_t)

;; notmuch_status_t notmuch_database_compact(const char *path, const char *
;;     backup_path, notmuch_compact_status_cb_t status_cb, void *closure);
(define notmuch_database_compact
  (let ((~notmuch_database_compact
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_compact"
                   (list ffi-void* ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (path backup_path status_cb closure)
      (let ((~path (unwrap~pointer path))
            (~backup_path (unwrap~pointer backup_path))
            (~status_cb
              ((fht-unwrap notmuch_compact_status_cb_t)
               status_cb))
            (~closure (unwrap~pointer closure)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_compact)
           ~path
           ~backup_path
           ~status_cb
           ~closure))))))
(export notmuch_database_compact)

;; notmuch_status_t notmuch_database_destroy(notmuch_database_t *database);
(define notmuch_database_destroy
  (let ((~notmuch_database_destroy
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_destroy) ~database))))))
(export notmuch_database_destroy)

;; const char *notmuch_database_get_path(notmuch_database_t *database);
(define notmuch_database_get_path
  (let ((~notmuch_database_get_path
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_database_get_path"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database)))
        ((force ~notmuch_database_get_path) ~database)))))
(export notmuch_database_get_path)

;; unsigned int notmuch_database_get_version(notmuch_database_t *database);
(define notmuch_database_get_version
  (let ((~notmuch_database_get_version
          (delay (fh-link-proc
                   ffi:unsigned-int
                   "notmuch_database_get_version"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database)))
        ((force ~notmuch_database_get_version) ~database)))))
(export notmuch_database_get_version)

;; notmuch_bool_t notmuch_database_needs_upgrade(notmuch_database_t *database);
;;     
(define notmuch_database_needs_upgrade
  (let ((~notmuch_database_needs_upgrade
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_needs_upgrade"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database)))
        ((force ~notmuch_database_needs_upgrade)
         ~database)))))
(export notmuch_database_needs_upgrade)

;; notmuch_status_t notmuch_database_upgrade(notmuch_database_t *database, void
;;      (*progress_notify)(void *closure, double progress), void *closure);
(define notmuch_database_upgrade
  (let ((~notmuch_database_upgrade
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_upgrade"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database progress_notify closure)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~progress_notify
              ((make-fctn-param-unwrapper
                 ffi:void
                 (list ffi-void* ffi:double))
               progress_notify))
            (~closure (unwrap~pointer closure)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_upgrade)
           ~database
           ~progress_notify
           ~closure))))))
(export notmuch_database_upgrade)

;; notmuch_status_t notmuch_database_begin_atomic(notmuch_database_t *notmuch);
;;     
(define notmuch_database_begin_atomic
  (let ((~notmuch_database_begin_atomic
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_begin_atomic"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (notmuch)
      (let ((~notmuch
              ((fht-unwrap notmuch_database_t*) notmuch)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_begin_atomic) ~notmuch))))))
(export notmuch_database_begin_atomic)

;; notmuch_status_t notmuch_database_end_atomic(notmuch_database_t *notmuch);
(define notmuch_database_end_atomic
  (let ((~notmuch_database_end_atomic
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_end_atomic"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (notmuch)
      (let ((~notmuch
              ((fht-unwrap notmuch_database_t*) notmuch)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_end_atomic) ~notmuch))))))
(export notmuch_database_end_atomic)

;; unsigned long notmuch_database_get_revision(notmuch_database_t *notmuch, 
;;     const char **uuid);
(define notmuch_database_get_revision
  (let ((~notmuch_database_get_revision
          (delay (fh-link-proc
                   ffi:unsigned-long
                   "notmuch_database_get_revision"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (notmuch uuid)
      (let ((~notmuch
              ((fht-unwrap notmuch_database_t*) notmuch))
            (~uuid (unwrap~pointer uuid)))
        ((force ~notmuch_database_get_revision)
         ~notmuch
         ~uuid)))))
(export notmuch_database_get_revision)

;; notmuch_status_t notmuch_database_get_directory(notmuch_database_t *database
;;     , const char *path, notmuch_directory_t **directory);
(define notmuch_database_get_directory
  (let ((~notmuch_database_get_directory
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_get_directory"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database path directory)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~path (unwrap~pointer path))
            (~directory (unwrap~pointer directory)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_get_directory)
           ~database
           ~path
           ~directory))))))
(export notmuch_database_get_directory)

;; notmuch_status_t notmuch_database_index_file(notmuch_database_t *database, 
;;     const char *filename, notmuch_indexopts_t *indexopts, notmuch_message_t 
;;     **message);
(define notmuch_database_index_file
  (let ((~notmuch_database_index_file
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_index_file"
                   (list ffi-void* ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database filename indexopts message)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~filename (unwrap~pointer filename))
            (~indexopts
              ((fht-unwrap notmuch_indexopts_t*) indexopts))
            (~message (unwrap~pointer message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_index_file)
           ~database
           ~filename
           ~indexopts
           ~message))))))
(export notmuch_database_index_file)

;; notmuch_status_t notmuch_database_add_message(notmuch_database_t *database, 
;;     const char *filename, notmuch_message_t **message);
(define notmuch_database_add_message
  (let ((~notmuch_database_add_message
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_add_message"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database filename message)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~filename (unwrap~pointer filename))
            (~message (unwrap~pointer message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_add_message)
           ~database
           ~filename
           ~message))))))
(export notmuch_database_add_message)

;; notmuch_status_t notmuch_database_remove_message(notmuch_database_t *
;;     database, const char *filename);
(define notmuch_database_remove_message
  (let ((~notmuch_database_remove_message
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_remove_message"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database filename)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~filename (unwrap~pointer filename)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_remove_message)
           ~database
           ~filename))))))
(export notmuch_database_remove_message)

;; notmuch_status_t notmuch_database_find_message(notmuch_database_t *database
;;     , const char *message_id, notmuch_message_t **message);
(define notmuch_database_find_message
  (let ((~notmuch_database_find_message
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_find_message"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database message_id message)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~message_id (unwrap~pointer message_id))
            (~message (unwrap~pointer message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_find_message)
           ~database
           ~message_id
           ~message))))))
(export notmuch_database_find_message)

;; notmuch_status_t notmuch_database_find_message_by_filename(
;;     notmuch_database_t *notmuch, const char *filename, notmuch_message_t **
;;     message);
(define notmuch_database_find_message_by_filename
  (let ((~notmuch_database_find_message_by_filename
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_find_message_by_filename"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (notmuch filename message)
      (let ((~notmuch
              ((fht-unwrap notmuch_database_t*) notmuch))
            (~filename (unwrap~pointer filename))
            (~message (unwrap~pointer message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_find_message_by_filename)
           ~notmuch
           ~filename
           ~message))))))
(export notmuch_database_find_message_by_filename)

;; notmuch_tags_t *notmuch_database_get_all_tags(notmuch_database_t *db);
(define notmuch_database_get_all_tags
  (let ((~notmuch_database_get_all_tags
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_database_get_all_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (db)
      (let ((~db ((fht-unwrap notmuch_database_t*) db)))
        ((fht-wrap notmuch_tags_t*)
         ((force ~notmuch_database_get_all_tags) ~db))))))
(export notmuch_database_get_all_tags)

;; notmuch_query_t *notmuch_query_create(notmuch_database_t *database, const 
;;     char *query_string);
(define notmuch_query_create
  (let ((~notmuch_query_create
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_query_create"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (database query_string)
      (let ((~database
              ((fht-unwrap notmuch_database_t*) database))
            (~query_string (unwrap~pointer query_string)))
        ((fht-wrap notmuch_query_t*)
         ((force ~notmuch_query_create)
          ~database
          ~query_string))))))
(export notmuch_query_create)

;; typedef enum {
;;   NOTMUCH_SORT_OLDEST_FIRST,
;;   NOTMUCH_SORT_NEWEST_FIRST,
;;   NOTMUCH_SORT_MESSAGE_ID,
;;   NOTMUCH_SORT_UNSORTED,
;; } notmuch_sort_t;
(define notmuch_sort_t-enum-nvl
  '((NOTMUCH_SORT_OLDEST_FIRST . 0)
    (NOTMUCH_SORT_NEWEST_FIRST . 1)
    (NOTMUCH_SORT_MESSAGE_ID . 2)
    (NOTMUCH_SORT_UNSORTED . 3))
  )
(define notmuch_sort_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_sort_t-enum-nvl))
(define-public (unwrap-notmuch_sort_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_sort_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_sort_t v)
  (assq-ref notmuch_sort_t-enum-vnl v))

;; const char *notmuch_query_get_query_string(const notmuch_query_t *query);
(define notmuch_query_get_query_string
  (let ((~notmuch_query_get_query_string
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_query_get_query_string"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query)
      (let ((~query ((fht-unwrap notmuch_query_t*) query)))
        ((force ~notmuch_query_get_query_string) ~query)))))
(export notmuch_query_get_query_string)

;; notmuch_database_t *notmuch_query_get_database(const notmuch_query_t *query)
;;     ;
(define notmuch_query_get_database
  (let ((~notmuch_query_get_database
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_query_get_database"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query)
      (let ((~query ((fht-unwrap notmuch_query_t*) query)))
        ((fht-wrap notmuch_database_t*)
         ((force ~notmuch_query_get_database) ~query))))))
(export notmuch_query_get_database)

;; typedef enum {
;;   NOTMUCH_EXCLUDE_FLAG,
;;   NOTMUCH_EXCLUDE_TRUE,
;;   NOTMUCH_EXCLUDE_FALSE,
;;   NOTMUCH_EXCLUDE_ALL,
;; } notmuch_exclude_t;
(define notmuch_exclude_t-enum-nvl
  '((NOTMUCH_EXCLUDE_FLAG . 0)
    (NOTMUCH_EXCLUDE_TRUE . 1)
    (NOTMUCH_EXCLUDE_FALSE . 2)
    (NOTMUCH_EXCLUDE_ALL . 3))
  )
(define notmuch_exclude_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_exclude_t-enum-nvl))
(define-public (unwrap-notmuch_exclude_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_exclude_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_exclude_t v)
  (assq-ref notmuch_exclude_t-enum-vnl v))

;; void notmuch_query_set_omit_excluded(notmuch_query_t *query, 
;;     notmuch_exclude_t omit_excluded);
(define notmuch_query_set_omit_excluded
  (let ((~notmuch_query_set_omit_excluded
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_query_set_omit_excluded"
                   (list ffi-void* ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (query omit_excluded)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~omit_excluded
              (unwrap-notmuch_exclude_t omit_excluded)))
        ((force ~notmuch_query_set_omit_excluded)
         ~query
         ~omit_excluded)))))
(export notmuch_query_set_omit_excluded)

;; void notmuch_query_set_sort(notmuch_query_t *query, notmuch_sort_t sort);
(define notmuch_query_set_sort
  (let ((~notmuch_query_set_sort
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_query_set_sort"
                   (list ffi-void* ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (query sort)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~sort (unwrap-notmuch_sort_t sort)))
        ((force ~notmuch_query_set_sort) ~query ~sort)))))
(export notmuch_query_set_sort)

;; notmuch_sort_t notmuch_query_get_sort(const notmuch_query_t *query);
(define notmuch_query_get_sort
  (let ((~notmuch_query_get_sort
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_get_sort"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query)
      (let ((~query ((fht-unwrap notmuch_query_t*) query)))
        (wrap-notmuch_sort_t
          ((force ~notmuch_query_get_sort) ~query))))))
(export notmuch_query_get_sort)

;; notmuch_status_t notmuch_query_add_tag_exclude(notmuch_query_t *query, const
;;      char *tag);
(define notmuch_query_add_tag_exclude
  (let ((~notmuch_query_add_tag_exclude
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_add_tag_exclude"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query tag)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~tag (unwrap~pointer tag)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_add_tag_exclude)
           ~query
           ~tag))))))
(export notmuch_query_add_tag_exclude)

;; notmuch_status_t notmuch_query_search_threads(notmuch_query_t *query, 
;;     notmuch_threads_t **out);
(define notmuch_query_search_threads
  (let ((~notmuch_query_search_threads
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_search_threads"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query out)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~out (unwrap~pointer out)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_search_threads)
           ~query
           ~out))))))
(export notmuch_query_search_threads)

;; notmuch_status_t notmuch_query_search_threads_st(notmuch_query_t *query, 
;;     notmuch_threads_t **out);
(define notmuch_query_search_threads_st
  (let ((~notmuch_query_search_threads_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_search_threads_st"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query out)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~out (unwrap~pointer out)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_search_threads_st)
           ~query
           ~out))))))
(export notmuch_query_search_threads_st)

;; notmuch_status_t notmuch_query_search_messages(notmuch_query_t *query, 
;;     notmuch_messages_t **out);
(define notmuch_query_search_messages
  (let ((~notmuch_query_search_messages
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_search_messages"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query out)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~out (unwrap~pointer out)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_search_messages)
           ~query
           ~out))))))
(export notmuch_query_search_messages)

;; notmuch_status_t notmuch_query_search_messages_st(notmuch_query_t *query, 
;;     notmuch_messages_t **out);
(define notmuch_query_search_messages_st
  (let ((~notmuch_query_search_messages_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_search_messages_st"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query out)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~out (unwrap~pointer out)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_search_messages_st)
           ~query
           ~out))))))
(export notmuch_query_search_messages_st)

;; void notmuch_query_destroy(notmuch_query_t *query);
(define notmuch_query_destroy
  (let ((~notmuch_query_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_query_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query)
      (let ((~query ((fht-unwrap notmuch_query_t*) query)))
        ((force ~notmuch_query_destroy) ~query)))))
(export notmuch_query_destroy)

;; notmuch_bool_t notmuch_threads_valid(notmuch_threads_t *threads);
(define notmuch_threads_valid
  (let ((~notmuch_threads_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_threads_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (threads)
      (let ((~threads
              ((fht-unwrap notmuch_threads_t*) threads)))
        ((force ~notmuch_threads_valid) ~threads)))))
(export notmuch_threads_valid)

;; notmuch_thread_t *notmuch_threads_get(notmuch_threads_t *threads);
(define notmuch_threads_get
  (let ((~notmuch_threads_get
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_threads_get"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (threads)
      (let ((~threads
              ((fht-unwrap notmuch_threads_t*) threads)))
        ((fht-wrap notmuch_thread_t*)
         ((force ~notmuch_threads_get) ~threads))))))
(export notmuch_threads_get)

;; void notmuch_threads_move_to_next(notmuch_threads_t *threads);
(define notmuch_threads_move_to_next
  (let ((~notmuch_threads_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_threads_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (threads)
      (let ((~threads
              ((fht-unwrap notmuch_threads_t*) threads)))
        ((force ~notmuch_threads_move_to_next) ~threads)))))
(export notmuch_threads_move_to_next)

;; void notmuch_threads_destroy(notmuch_threads_t *threads);
(define notmuch_threads_destroy
  (let ((~notmuch_threads_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_threads_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (threads)
      (let ((~threads
              ((fht-unwrap notmuch_threads_t*) threads)))
        ((force ~notmuch_threads_destroy) ~threads)))))
(export notmuch_threads_destroy)

;; notmuch_status_t notmuch_query_count_messages(notmuch_query_t *query, 
;;     unsigned int *count);
(define notmuch_query_count_messages
  (let ((~notmuch_query_count_messages
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_count_messages"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query count)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~count (unwrap~pointer count)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_count_messages)
           ~query
           ~count))))))
(export notmuch_query_count_messages)

;; notmuch_status_t notmuch_query_count_messages_st(notmuch_query_t *query, 
;;     unsigned int *count);
(define notmuch_query_count_messages_st
  (let ((~notmuch_query_count_messages_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_count_messages_st"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query count)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~count (unwrap~pointer count)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_count_messages_st)
           ~query
           ~count))))))
(export notmuch_query_count_messages_st)

;; notmuch_status_t notmuch_query_count_threads(notmuch_query_t *query, 
;;     unsigned *count);
(define notmuch_query_count_threads
  (let ((~notmuch_query_count_threads
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_count_threads"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query count)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~count (unwrap~pointer count)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_count_threads)
           ~query
           ~count))))))
(export notmuch_query_count_threads)

;; notmuch_status_t notmuch_query_count_threads_st(notmuch_query_t *query, 
;;     unsigned *count);
(define notmuch_query_count_threads_st
  (let ((~notmuch_query_count_threads_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_query_count_threads_st"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (query count)
      (let ((~query ((fht-unwrap notmuch_query_t*) query))
            (~count (unwrap~pointer count)))
        (wrap-notmuch_status_t
          ((force ~notmuch_query_count_threads_st)
           ~query
           ~count))))))
(export notmuch_query_count_threads_st)

;; const char *notmuch_thread_get_thread_id(notmuch_thread_t *thread);
(define notmuch_thread_get_thread_id
  (let ((~notmuch_thread_get_thread_id
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_thread_id"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_thread_id) ~thread)))))
(export notmuch_thread_get_thread_id)

;; int notmuch_thread_get_total_messages(notmuch_thread_t *thread);
(define notmuch_thread_get_total_messages
  (let ((~notmuch_thread_get_total_messages
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_thread_get_total_messages"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_total_messages)
         ~thread)))))
(export notmuch_thread_get_total_messages)

;; int notmuch_thread_get_total_files(notmuch_thread_t *thread);
(define notmuch_thread_get_total_files
  (let ((~notmuch_thread_get_total_files
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_thread_get_total_files"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_total_files) ~thread)))))
(export notmuch_thread_get_total_files)

;; notmuch_messages_t *notmuch_thread_get_toplevel_messages(notmuch_thread_t *
;;     thread);
(define notmuch_thread_get_toplevel_messages
  (let ((~notmuch_thread_get_toplevel_messages
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_toplevel_messages"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((fht-wrap notmuch_messages_t*)
         ((force ~notmuch_thread_get_toplevel_messages)
          ~thread))))))
(export notmuch_thread_get_toplevel_messages)

;; notmuch_messages_t *notmuch_thread_get_messages(notmuch_thread_t *thread);
(define notmuch_thread_get_messages
  (let ((~notmuch_thread_get_messages
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_messages"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((fht-wrap notmuch_messages_t*)
         ((force ~notmuch_thread_get_messages) ~thread))))))
(export notmuch_thread_get_messages)

;; int notmuch_thread_get_matched_messages(notmuch_thread_t *thread);
(define notmuch_thread_get_matched_messages
  (let ((~notmuch_thread_get_matched_messages
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_thread_get_matched_messages"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_matched_messages)
         ~thread)))))
(export notmuch_thread_get_matched_messages)

;; const char *notmuch_thread_get_authors(notmuch_thread_t *thread);
(define notmuch_thread_get_authors
  (let ((~notmuch_thread_get_authors
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_authors"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_authors) ~thread)))))
(export notmuch_thread_get_authors)

;; const char *notmuch_thread_get_subject(notmuch_thread_t *thread);
(define notmuch_thread_get_subject
  (let ((~notmuch_thread_get_subject
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_subject"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_subject) ~thread)))))
(export notmuch_thread_get_subject)

;; time_t notmuch_thread_get_oldest_date(notmuch_thread_t *thread);
(define notmuch_thread_get_oldest_date
  (let ((~notmuch_thread_get_oldest_date
          (delay (fh-link-proc
                   ffi:long
                   "notmuch_thread_get_oldest_date"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_oldest_date) ~thread)))))
(export notmuch_thread_get_oldest_date)

;; time_t notmuch_thread_get_newest_date(notmuch_thread_t *thread);
(define notmuch_thread_get_newest_date
  (let ((~notmuch_thread_get_newest_date
          (delay (fh-link-proc
                   ffi:long
                   "notmuch_thread_get_newest_date"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_get_newest_date) ~thread)))))
(export notmuch_thread_get_newest_date)

;; notmuch_tags_t *notmuch_thread_get_tags(notmuch_thread_t *thread);
(define notmuch_thread_get_tags
  (let ((~notmuch_thread_get_tags
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_thread_get_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((fht-wrap notmuch_tags_t*)
         ((force ~notmuch_thread_get_tags) ~thread))))))
(export notmuch_thread_get_tags)

;; void notmuch_thread_destroy(notmuch_thread_t *thread);
(define notmuch_thread_destroy
  (let ((~notmuch_thread_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_thread_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (thread)
      (let ((~thread ((fht-unwrap notmuch_thread_t*) thread)))
        ((force ~notmuch_thread_destroy) ~thread)))))
(export notmuch_thread_destroy)

;; notmuch_bool_t notmuch_messages_valid(notmuch_messages_t *messages);
(define notmuch_messages_valid
  (let ((~notmuch_messages_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_messages_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (messages)
      (let ((~messages
              ((fht-unwrap notmuch_messages_t*) messages)))
        ((force ~notmuch_messages_valid) ~messages)))))
(export notmuch_messages_valid)

;; notmuch_message_t *notmuch_messages_get(notmuch_messages_t *messages);
(define notmuch_messages_get
  (let ((~notmuch_messages_get
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_messages_get"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (messages)
      (let ((~messages
              ((fht-unwrap notmuch_messages_t*) messages)))
        ((fht-wrap notmuch_message_t*)
         ((force ~notmuch_messages_get) ~messages))))))
(export notmuch_messages_get)

;; void notmuch_messages_move_to_next(notmuch_messages_t *messages);
(define notmuch_messages_move_to_next
  (let ((~notmuch_messages_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_messages_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (messages)
      (let ((~messages
              ((fht-unwrap notmuch_messages_t*) messages)))
        ((force ~notmuch_messages_move_to_next)
         ~messages)))))
(export notmuch_messages_move_to_next)

;; void notmuch_messages_destroy(notmuch_messages_t *messages);
(define notmuch_messages_destroy
  (let ((~notmuch_messages_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_messages_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (messages)
      (let ((~messages
              ((fht-unwrap notmuch_messages_t*) messages)))
        ((force ~notmuch_messages_destroy) ~messages)))))
(export notmuch_messages_destroy)

;; notmuch_tags_t *notmuch_messages_collect_tags(notmuch_messages_t *messages);
;;     
(define notmuch_messages_collect_tags
  (let ((~notmuch_messages_collect_tags
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_messages_collect_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (messages)
      (let ((~messages
              ((fht-unwrap notmuch_messages_t*) messages)))
        ((fht-wrap notmuch_tags_t*)
         ((force ~notmuch_messages_collect_tags)
          ~messages))))))
(export notmuch_messages_collect_tags)

;; notmuch_database_t *notmuch_message_get_database(const notmuch_message_t *
;;     message);
(define notmuch_message_get_database
  (let ((~notmuch_message_get_database
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_database"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((fht-wrap notmuch_database_t*)
         ((force ~notmuch_message_get_database) ~message))))))
(export notmuch_message_get_database)

;; const char *notmuch_message_get_message_id(notmuch_message_t *message);
(define notmuch_message_get_message_id
  (let ((~notmuch_message_get_message_id
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_message_id"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_get_message_id)
         ~message)))))
(export notmuch_message_get_message_id)

;; const char *notmuch_message_get_thread_id(notmuch_message_t *message);
(define notmuch_message_get_thread_id
  (let ((~notmuch_message_get_thread_id
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_thread_id"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_get_thread_id) ~message)))))
(export notmuch_message_get_thread_id)

;; notmuch_messages_t *notmuch_message_get_replies(notmuch_message_t *message);
;;     
(define notmuch_message_get_replies
  (let ((~notmuch_message_get_replies
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_replies"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((fht-wrap notmuch_messages_t*)
         ((force ~notmuch_message_get_replies) ~message))))))
(export notmuch_message_get_replies)

;; int notmuch_message_count_files(notmuch_message_t *message);
(define notmuch_message_count_files
  (let ((~notmuch_message_count_files
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_count_files"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_count_files) ~message)))))
(export notmuch_message_count_files)

;; const char *notmuch_message_get_filename(notmuch_message_t *message);
(define notmuch_message_get_filename
  (let ((~notmuch_message_get_filename
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_filename"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_get_filename) ~message)))))
(export notmuch_message_get_filename)

;; notmuch_filenames_t *notmuch_message_get_filenames(notmuch_message_t *
;;     message);
(define notmuch_message_get_filenames
  (let ((~notmuch_message_get_filenames
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_filenames"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((fht-wrap notmuch_filenames_t*)
         ((force ~notmuch_message_get_filenames) ~message))))))
(export notmuch_message_get_filenames)

;; notmuch_status_t notmuch_message_reindex(notmuch_message_t *message, 
;;     notmuch_indexopts_t *indexopts);
(define notmuch_message_reindex
  (let ((~notmuch_message_reindex
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_reindex"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message indexopts)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~indexopts
              ((fht-unwrap notmuch_indexopts_t*) indexopts)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_reindex)
           ~message
           ~indexopts))))))
(export notmuch_message_reindex)

;; typedef enum _notmuch_message_flag {
;;   NOTMUCH_MESSAGE_FLAG_MATCH,
;;   NOTMUCH_MESSAGE_FLAG_EXCLUDED,
;;   NOTMUCH_MESSAGE_FLAG_GHOST,
;; } notmuch_message_flag_t;
(define notmuch_message_flag_t-enum-nvl
  '((NOTMUCH_MESSAGE_FLAG_MATCH . 0)
    (NOTMUCH_MESSAGE_FLAG_EXCLUDED . 1)
    (NOTMUCH_MESSAGE_FLAG_GHOST . 2))
  )
(define notmuch_message_flag_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_message_flag_t-enum-nvl))
(define-public (unwrap-notmuch_message_flag_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_message_flag_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_message_flag_t v)
  (assq-ref notmuch_message_flag_t-enum-vnl v))
(define-public unwrap-enum-_notmuch_message_flag unwrap-notmuch_message_flag_t)
(define-public wrap-enum-_notmuch_message_flag wrap-notmuch_message_flag_t)

;; enum _notmuch_message_flag {
;;   NOTMUCH_MESSAGE_FLAG_MATCH,
;;   NOTMUCH_MESSAGE_FLAG_EXCLUDED,
;;   NOTMUCH_MESSAGE_FLAG_GHOST,
;; };

;; notmuch_bool_t notmuch_message_get_flag(notmuch_message_t *message, 
;;     notmuch_message_flag_t flag);
(define notmuch_message_get_flag
  (let ((~notmuch_message_get_flag
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_get_flag"
                   (list ffi-void* ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (message flag)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~flag (unwrap-notmuch_message_flag_t flag)))
        ((force ~notmuch_message_get_flag)
         ~message
         ~flag)))))
(export notmuch_message_get_flag)

;; notmuch_status_t notmuch_message_get_flag_st(notmuch_message_t *message, 
;;     notmuch_message_flag_t flag, notmuch_bool_t *is_set);
(define notmuch_message_get_flag_st
  (let ((~notmuch_message_get_flag_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_get_flag_st"
                   (list ffi-void* ffi:int ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message flag is_set)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~flag (unwrap-notmuch_message_flag_t flag))
            (~is_set (unwrap~pointer is_set)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_get_flag_st)
           ~message
           ~flag
           ~is_set))))))
(export notmuch_message_get_flag_st)

;; void notmuch_message_set_flag(notmuch_message_t *message, 
;;     notmuch_message_flag_t flag, notmuch_bool_t value);
(define notmuch_message_set_flag
  (let ((~notmuch_message_set_flag
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_message_set_flag"
                   (list ffi-void* ffi:int ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (message flag value)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~flag (unwrap-notmuch_message_flag_t flag))
            (~value (unwrap~fixed value)))
        ((force ~notmuch_message_set_flag)
         ~message
         ~flag
         ~value)))))
(export notmuch_message_set_flag)

;; time_t notmuch_message_get_date(notmuch_message_t *message);
(define notmuch_message_get_date
  (let ((~notmuch_message_get_date
          (delay (fh-link-proc
                   ffi:long
                   "notmuch_message_get_date"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_get_date) ~message)))))
(export notmuch_message_get_date)

;; const char *notmuch_message_get_header(notmuch_message_t *message, const 
;;     char *header);
(define notmuch_message_get_header
  (let ((~notmuch_message_get_header
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_header"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message header)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~header (unwrap~pointer header)))
        ((force ~notmuch_message_get_header)
         ~message
         ~header)))))
(export notmuch_message_get_header)

;; notmuch_tags_t *notmuch_message_get_tags(notmuch_message_t *message);
(define notmuch_message_get_tags
  (let ((~notmuch_message_get_tags
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((fht-wrap notmuch_tags_t*)
         ((force ~notmuch_message_get_tags) ~message))))))
(export notmuch_message_get_tags)

;; notmuch_status_t notmuch_message_add_tag(notmuch_message_t *message, const 
;;     char *tag);
(define notmuch_message_add_tag
  (let ((~notmuch_message_add_tag
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_add_tag"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message tag)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~tag (unwrap~pointer tag)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_add_tag) ~message ~tag))))))
(export notmuch_message_add_tag)

;; notmuch_status_t notmuch_message_remove_tag(notmuch_message_t *message, 
;;     const char *tag);
(define notmuch_message_remove_tag
  (let ((~notmuch_message_remove_tag
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_remove_tag"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message tag)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~tag (unwrap~pointer tag)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_remove_tag)
           ~message
           ~tag))))))
(export notmuch_message_remove_tag)

;; notmuch_status_t notmuch_message_remove_all_tags(notmuch_message_t *message)
;;     ;
(define notmuch_message_remove_all_tags
  (let ((~notmuch_message_remove_all_tags
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_remove_all_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_remove_all_tags)
           ~message))))))
(export notmuch_message_remove_all_tags)

;; notmuch_status_t notmuch_message_maildir_flags_to_tags(notmuch_message_t *
;;     message);
(define notmuch_message_maildir_flags_to_tags
  (let ((~notmuch_message_maildir_flags_to_tags
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_maildir_flags_to_tags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_maildir_flags_to_tags)
           ~message))))))
(export notmuch_message_maildir_flags_to_tags)

;; notmuch_bool_t notmuch_message_has_maildir_flag(notmuch_message_t *message, 
;;     char flag);
(define notmuch_message_has_maildir_flag
  (let ((~notmuch_message_has_maildir_flag
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_has_maildir_flag"
                   (list ffi-void* ffi:int8)
                   (force ffi-notmuch-llibs)))))
    (lambda (message flag)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~flag (unwrap~fixed flag)))
        ((force ~notmuch_message_has_maildir_flag)
         ~message
         ~flag)))))
(export notmuch_message_has_maildir_flag)

;; notmuch_status_t notmuch_message_has_maildir_flag_st(notmuch_message_t *
;;     message, char flag, notmuch_bool_t *is_set);
(define notmuch_message_has_maildir_flag_st
  (let ((~notmuch_message_has_maildir_flag_st
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_has_maildir_flag_st"
                   (list ffi-void* ffi:int8 ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message flag is_set)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~flag (unwrap~fixed flag))
            (~is_set (unwrap~pointer is_set)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_has_maildir_flag_st)
           ~message
           ~flag
           ~is_set))))))
(export notmuch_message_has_maildir_flag_st)

;; notmuch_status_t notmuch_message_tags_to_maildir_flags(notmuch_message_t *
;;     message);
(define notmuch_message_tags_to_maildir_flags
  (let ((~notmuch_message_tags_to_maildir_flags
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_tags_to_maildir_flags"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_tags_to_maildir_flags)
           ~message))))))
(export notmuch_message_tags_to_maildir_flags)

;; notmuch_status_t notmuch_message_freeze(notmuch_message_t *message);
(define notmuch_message_freeze
  (let ((~notmuch_message_freeze
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_freeze"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_freeze) ~message))))))
(export notmuch_message_freeze)

;; notmuch_status_t notmuch_message_thaw(notmuch_message_t *message);
(define notmuch_message_thaw
  (let ((~notmuch_message_thaw
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_thaw"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_thaw) ~message))))))
(export notmuch_message_thaw)

;; void notmuch_message_destroy(notmuch_message_t *message);
(define notmuch_message_destroy
  (let ((~notmuch_message_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_message_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message)))
        ((force ~notmuch_message_destroy) ~message)))))
(export notmuch_message_destroy)

;; notmuch_status_t notmuch_message_get_property(notmuch_message_t *message, 
;;     const char *key, const char **value);
(define notmuch_message_get_property
  (let ((~notmuch_message_get_property
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_get_property"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key value)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key))
            (~value (unwrap~pointer value)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_get_property)
           ~message
           ~key
           ~value))))))
(export notmuch_message_get_property)

;; notmuch_status_t notmuch_message_add_property(notmuch_message_t *message, 
;;     const char *key, const char *value);
(define notmuch_message_add_property
  (let ((~notmuch_message_add_property
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_add_property"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key value)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key))
            (~value (unwrap~pointer value)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_add_property)
           ~message
           ~key
           ~value))))))
(export notmuch_message_add_property)

;; notmuch_status_t notmuch_message_remove_property(notmuch_message_t *message
;;     , const char *key, const char *value);
(define notmuch_message_remove_property
  (let ((~notmuch_message_remove_property
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_remove_property"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key value)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key))
            (~value (unwrap~pointer value)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_remove_property)
           ~message
           ~key
           ~value))))))
(export notmuch_message_remove_property)

;; notmuch_status_t notmuch_message_remove_all_properties(notmuch_message_t *
;;     message, const char *key);
(define notmuch_message_remove_all_properties
  (let ((~notmuch_message_remove_all_properties
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_remove_all_properties"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_remove_all_properties)
           ~message
           ~key))))))
(export notmuch_message_remove_all_properties)

;; notmuch_status_t notmuch_message_remove_all_properties_with_prefix(
;;     notmuch_message_t *message, const char *prefix);
(define notmuch_message_remove_all_properties_with_prefix
  (let ((~notmuch_message_remove_all_properties_with_prefix
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_remove_all_properties_with_prefix"
                   (list ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message prefix)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~prefix (unwrap~pointer prefix)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_remove_all_properties_with_prefix)
           ~message
           ~prefix))))))
(export notmuch_message_remove_all_properties_with_prefix)

;; typedef struct _notmuch_string_map_iterator notmuch_message_properties_t;
(define-public notmuch_message_properties_t-desc 'void)
(define-fh-type-alias notmuch_message_properties_t fh-void)
(define-public notmuch_message_properties_t? fh-void?)
(define-public make-notmuch_message_properties_t make-fh-void)
(define-public notmuch_message_properties_t*-desc (fh:pointer notmuch_message_properties_t-desc))
(define-fh-pointer-type notmuch_message_properties_t* 
 notmuch_message_properties_t*-desc notmuch_message_properties_t*? 
 make-notmuch_message_properties_t*)
(export notmuch_message_properties_t* notmuch_message_properties_t*? 
 make-notmuch_message_properties_t*)

;; notmuch_message_properties_t *notmuch_message_get_properties(
;;     notmuch_message_t *message, const char *key, notmuch_bool_t exact);
(define notmuch_message_get_properties
  (let ((~notmuch_message_get_properties
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_get_properties"
                   (list ffi-void* ffi-void* ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key exact)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key))
            (~exact (unwrap~fixed exact)))
        ((fht-wrap notmuch_message_properties_t*)
         ((force ~notmuch_message_get_properties)
          ~message
          ~key
          ~exact))))))
(export notmuch_message_get_properties)

;; notmuch_status_t notmuch_message_count_properties(notmuch_message_t *message
;;     , const char *key, unsigned int *count);
(define notmuch_message_count_properties
  (let ((~notmuch_message_count_properties
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_count_properties"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (message key count)
      (let ((~message
              ((fht-unwrap notmuch_message_t*) message))
            (~key (unwrap~pointer key))
            (~count (unwrap~pointer count)))
        (wrap-notmuch_status_t
          ((force ~notmuch_message_count_properties)
           ~message
           ~key
           ~count))))))
(export notmuch_message_count_properties)

;; notmuch_bool_t notmuch_message_properties_valid(notmuch_message_properties_t
;;      *properties);
(define notmuch_message_properties_valid
  (let ((~notmuch_message_properties_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_message_properties_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (properties)
      (let ((~properties
              ((fht-unwrap notmuch_message_properties_t*)
               properties)))
        ((force ~notmuch_message_properties_valid)
         ~properties)))))
(export notmuch_message_properties_valid)

;; void notmuch_message_properties_move_to_next(notmuch_message_properties_t *
;;     properties);
(define notmuch_message_properties_move_to_next
  (let ((~notmuch_message_properties_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_message_properties_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (properties)
      (let ((~properties
              ((fht-unwrap notmuch_message_properties_t*)
               properties)))
        ((force ~notmuch_message_properties_move_to_next)
         ~properties)))))
(export notmuch_message_properties_move_to_next)

;; const char *notmuch_message_properties_key(notmuch_message_properties_t *
;;     properties);
(define notmuch_message_properties_key
  (let ((~notmuch_message_properties_key
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_properties_key"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (properties)
      (let ((~properties
              ((fht-unwrap notmuch_message_properties_t*)
               properties)))
        ((force ~notmuch_message_properties_key)
         ~properties)))))
(export notmuch_message_properties_key)

;; const char *notmuch_message_properties_value(notmuch_message_properties_t *
;;     properties);
(define notmuch_message_properties_value
  (let ((~notmuch_message_properties_value
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_message_properties_value"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (properties)
      (let ((~properties
              ((fht-unwrap notmuch_message_properties_t*)
               properties)))
        ((force ~notmuch_message_properties_value)
         ~properties)))))
(export notmuch_message_properties_value)

;; void notmuch_message_properties_destroy(notmuch_message_properties_t *
;;     properties);
(define notmuch_message_properties_destroy
  (let ((~notmuch_message_properties_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_message_properties_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (properties)
      (let ((~properties
              ((fht-unwrap notmuch_message_properties_t*)
               properties)))
        ((force ~notmuch_message_properties_destroy)
         ~properties)))))
(export notmuch_message_properties_destroy)

;; notmuch_bool_t notmuch_tags_valid(notmuch_tags_t *tags);
(define notmuch_tags_valid
  (let ((~notmuch_tags_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_tags_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (tags)
      (let ((~tags ((fht-unwrap notmuch_tags_t*) tags)))
        ((force ~notmuch_tags_valid) ~tags)))))
(export notmuch_tags_valid)

;; const char *notmuch_tags_get(notmuch_tags_t *tags);
(define notmuch_tags_get
  (let ((~notmuch_tags_get
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_tags_get"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (tags)
      (let ((~tags ((fht-unwrap notmuch_tags_t*) tags)))
        ((force ~notmuch_tags_get) ~tags)))))
(export notmuch_tags_get)

;; void notmuch_tags_move_to_next(notmuch_tags_t *tags);
(define notmuch_tags_move_to_next
  (let ((~notmuch_tags_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_tags_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (tags)
      (let ((~tags ((fht-unwrap notmuch_tags_t*) tags)))
        ((force ~notmuch_tags_move_to_next) ~tags)))))
(export notmuch_tags_move_to_next)

;; void notmuch_tags_destroy(notmuch_tags_t *tags);
(define notmuch_tags_destroy
  (let ((~notmuch_tags_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_tags_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (tags)
      (let ((~tags ((fht-unwrap notmuch_tags_t*) tags)))
        ((force ~notmuch_tags_destroy) ~tags)))))
(export notmuch_tags_destroy)

;; notmuch_status_t notmuch_directory_set_mtime(notmuch_directory_t *directory
;;     , time_t mtime);
(define notmuch_directory_set_mtime
  (let ((~notmuch_directory_set_mtime
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_directory_set_mtime"
                   (list ffi-void* ffi:long)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory mtime)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory))
            (~mtime (unwrap~fixed mtime)))
        (wrap-notmuch_status_t
          ((force ~notmuch_directory_set_mtime)
           ~directory
           ~mtime))))))
(export notmuch_directory_set_mtime)

;; time_t notmuch_directory_get_mtime(notmuch_directory_t *directory);
(define notmuch_directory_get_mtime
  (let ((~notmuch_directory_get_mtime
          (delay (fh-link-proc
                   ffi:long
                   "notmuch_directory_get_mtime"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory)))
        ((force ~notmuch_directory_get_mtime) ~directory)))))
(export notmuch_directory_get_mtime)

;; notmuch_filenames_t *notmuch_directory_get_child_files(notmuch_directory_t *
;;     directory);
(define notmuch_directory_get_child_files
  (let ((~notmuch_directory_get_child_files
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_directory_get_child_files"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory)))
        ((fht-wrap notmuch_filenames_t*)
         ((force ~notmuch_directory_get_child_files)
          ~directory))))))
(export notmuch_directory_get_child_files)

;; notmuch_filenames_t *notmuch_directory_get_child_directories(
;;     notmuch_directory_t *directory);
(define notmuch_directory_get_child_directories
  (let ((~notmuch_directory_get_child_directories
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_directory_get_child_directories"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory)))
        ((fht-wrap notmuch_filenames_t*)
         ((force ~notmuch_directory_get_child_directories)
          ~directory))))))
(export notmuch_directory_get_child_directories)

;; notmuch_status_t notmuch_directory_delete(notmuch_directory_t *directory);
(define notmuch_directory_delete
  (let ((~notmuch_directory_delete
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_directory_delete"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory)))
        (wrap-notmuch_status_t
          ((force ~notmuch_directory_delete) ~directory))))))
(export notmuch_directory_delete)

;; void notmuch_directory_destroy(notmuch_directory_t *directory);
(define notmuch_directory_destroy
  (let ((~notmuch_directory_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_directory_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (directory)
      (let ((~directory
              ((fht-unwrap notmuch_directory_t*) directory)))
        ((force ~notmuch_directory_destroy) ~directory)))))
(export notmuch_directory_destroy)

;; notmuch_bool_t notmuch_filenames_valid(notmuch_filenames_t *filenames);
(define notmuch_filenames_valid
  (let ((~notmuch_filenames_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_filenames_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (filenames)
      (let ((~filenames
              ((fht-unwrap notmuch_filenames_t*) filenames)))
        ((force ~notmuch_filenames_valid) ~filenames)))))
(export notmuch_filenames_valid)

;; const char *notmuch_filenames_get(notmuch_filenames_t *filenames);
(define notmuch_filenames_get
  (let ((~notmuch_filenames_get
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_filenames_get"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (filenames)
      (let ((~filenames
              ((fht-unwrap notmuch_filenames_t*) filenames)))
        ((force ~notmuch_filenames_get) ~filenames)))))
(export notmuch_filenames_get)

;; void notmuch_filenames_move_to_next(notmuch_filenames_t *filenames);
(define notmuch_filenames_move_to_next
  (let ((~notmuch_filenames_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_filenames_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (filenames)
      (let ((~filenames
              ((fht-unwrap notmuch_filenames_t*) filenames)))
        ((force ~notmuch_filenames_move_to_next)
         ~filenames)))))
(export notmuch_filenames_move_to_next)

;; void notmuch_filenames_destroy(notmuch_filenames_t *filenames);
(define notmuch_filenames_destroy
  (let ((~notmuch_filenames_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_filenames_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (filenames)
      (let ((~filenames
              ((fht-unwrap notmuch_filenames_t*) filenames)))
        ((force ~notmuch_filenames_destroy) ~filenames)))))
(export notmuch_filenames_destroy)

;; notmuch_status_t notmuch_database_set_config(notmuch_database_t *db, const 
;;     char *key, const char *value);
(define notmuch_database_set_config
  (let ((~notmuch_database_set_config
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_set_config"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (db key value)
      (let ((~db ((fht-unwrap notmuch_database_t*) db))
            (~key (unwrap~pointer key))
            (~value (unwrap~pointer value)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_set_config)
           ~db
           ~key
           ~value))))))
(export notmuch_database_set_config)

;; notmuch_status_t notmuch_database_get_config(notmuch_database_t *db, const 
;;     char *key, char **value);
(define notmuch_database_get_config
  (let ((~notmuch_database_get_config
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_get_config"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (db key value)
      (let ((~db ((fht-unwrap notmuch_database_t*) db))
            (~key (unwrap~pointer key))
            (~value (unwrap~pointer value)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_get_config)
           ~db
           ~key
           ~value))))))
(export notmuch_database_get_config)

;; notmuch_status_t notmuch_database_get_config_list(notmuch_database_t *db, 
;;     const char *prefix, notmuch_config_list_t **out);
(define notmuch_database_get_config_list
  (let ((~notmuch_database_get_config_list
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_database_get_config_list"
                   (list ffi-void* ffi-void* ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (db prefix out)
      (let ((~db ((fht-unwrap notmuch_database_t*) db))
            (~prefix (unwrap~pointer prefix))
            (~out (unwrap~pointer out)))
        (wrap-notmuch_status_t
          ((force ~notmuch_database_get_config_list)
           ~db
           ~prefix
           ~out))))))
(export notmuch_database_get_config_list)

;; notmuch_bool_t notmuch_config_list_valid(notmuch_config_list_t *config_list)
;;     ;
(define notmuch_config_list_valid
  (let ((~notmuch_config_list_valid
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_config_list_valid"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (config_list)
      (let ((~config_list
              ((fht-unwrap notmuch_config_list_t*) config_list)))
        ((force ~notmuch_config_list_valid) ~config_list)))))
(export notmuch_config_list_valid)

;; const char *notmuch_config_list_key(notmuch_config_list_t *config_list);
(define notmuch_config_list_key
  (let ((~notmuch_config_list_key
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_config_list_key"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (config_list)
      (let ((~config_list
              ((fht-unwrap notmuch_config_list_t*) config_list)))
        ((force ~notmuch_config_list_key) ~config_list)))))
(export notmuch_config_list_key)

;; const char *notmuch_config_list_value(notmuch_config_list_t *config_list);
(define notmuch_config_list_value
  (let ((~notmuch_config_list_value
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_config_list_value"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (config_list)
      (let ((~config_list
              ((fht-unwrap notmuch_config_list_t*) config_list)))
        ((force ~notmuch_config_list_value) ~config_list)))))
(export notmuch_config_list_value)

;; void notmuch_config_list_move_to_next(notmuch_config_list_t *config_list);
(define notmuch_config_list_move_to_next
  (let ((~notmuch_config_list_move_to_next
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_config_list_move_to_next"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (config_list)
      (let ((~config_list
              ((fht-unwrap notmuch_config_list_t*) config_list)))
        ((force ~notmuch_config_list_move_to_next)
         ~config_list)))))
(export notmuch_config_list_move_to_next)

;; void notmuch_config_list_destroy(notmuch_config_list_t *config_list);
(define notmuch_config_list_destroy
  (let ((~notmuch_config_list_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_config_list_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (config_list)
      (let ((~config_list
              ((fht-unwrap notmuch_config_list_t*) config_list)))
        ((force ~notmuch_config_list_destroy)
         ~config_list)))))
(export notmuch_config_list_destroy)

;; notmuch_indexopts_t *notmuch_database_get_default_indexopts(
;;     notmuch_database_t *db);
(define notmuch_database_get_default_indexopts
  (let ((~notmuch_database_get_default_indexopts
          (delay (fh-link-proc
                   ffi-void*
                   "notmuch_database_get_default_indexopts"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (db)
      (let ((~db ((fht-unwrap notmuch_database_t*) db)))
        ((fht-wrap notmuch_indexopts_t*)
         ((force ~notmuch_database_get_default_indexopts)
          ~db))))))
(export notmuch_database_get_default_indexopts)

;; typedef enum {
;;   NOTMUCH_DECRYPT_FALSE,
;;   NOTMUCH_DECRYPT_TRUE,
;;   NOTMUCH_DECRYPT_AUTO,
;;   NOTMUCH_DECRYPT_NOSTASH,
;; } notmuch_decryption_policy_t;
(define notmuch_decryption_policy_t-enum-nvl
  '((NOTMUCH_DECRYPT_FALSE . 0)
    (NOTMUCH_DECRYPT_TRUE . 1)
    (NOTMUCH_DECRYPT_AUTO . 2)
    (NOTMUCH_DECRYPT_NOSTASH . 3))
  )
(define notmuch_decryption_policy_t-enum-vnl
  (map (lambda (pair) (cons (cdr pair) (car pair)))
       notmuch_decryption_policy_t-enum-nvl))
(define-public (unwrap-notmuch_decryption_policy_t n)
  (cond
   ((symbol? n)
    (or (assq-ref notmuch_decryption_policy_t-enum-nvl n) (error "bad arg")))
   ((integer? n) n)
   (else (error "bad arg"))))
(define-public (wrap-notmuch_decryption_policy_t v)
  (assq-ref notmuch_decryption_policy_t-enum-vnl v))

;; notmuch_status_t notmuch_indexopts_set_decrypt_policy(notmuch_indexopts_t *
;;     indexopts, notmuch_decryption_policy_t decrypt_policy);
(define notmuch_indexopts_set_decrypt_policy
  (let ((~notmuch_indexopts_set_decrypt_policy
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_indexopts_set_decrypt_policy"
                   (list ffi-void* ffi:int)
                   (force ffi-notmuch-llibs)))))
    (lambda (indexopts decrypt_policy)
      (let ((~indexopts
              ((fht-unwrap notmuch_indexopts_t*) indexopts))
            (~decrypt_policy
              (unwrap-notmuch_decryption_policy_t
                decrypt_policy)))
        (wrap-notmuch_status_t
          ((force ~notmuch_indexopts_set_decrypt_policy)
           ~indexopts
           ~decrypt_policy))))))
(export notmuch_indexopts_set_decrypt_policy)

;; notmuch_decryption_policy_t notmuch_indexopts_get_decrypt_policy(const 
;;     notmuch_indexopts_t *indexopts);
(define notmuch_indexopts_get_decrypt_policy
  (let ((~notmuch_indexopts_get_decrypt_policy
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_indexopts_get_decrypt_policy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (indexopts)
      (let ((~indexopts
              ((fht-unwrap notmuch_indexopts_t*) indexopts)))
        (wrap-notmuch_decryption_policy_t
          ((force ~notmuch_indexopts_get_decrypt_policy)
           ~indexopts))))))
(export notmuch_indexopts_get_decrypt_policy)

;; void notmuch_indexopts_destroy(notmuch_indexopts_t *options);
(define notmuch_indexopts_destroy
  (let ((~notmuch_indexopts_destroy
          (delay (fh-link-proc
                   ffi:void
                   "notmuch_indexopts_destroy"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (options)
      (let ((~options
              ((fht-unwrap notmuch_indexopts_t*) options)))
        ((force ~notmuch_indexopts_destroy) ~options)))))
(export notmuch_indexopts_destroy)

;; notmuch_bool_t notmuch_built_with(const char *name);
(define notmuch_built_with
  (let ((~notmuch_built_with
          (delay (fh-link-proc
                   ffi:int
                   "notmuch_built_with"
                   (list ffi-void*)
                   (force ffi-notmuch-llibs)))))
    (lambda (name)
      (let ((~name (unwrap~pointer name)))
        ((force ~notmuch_built_with) ~name)))))
(export notmuch_built_with)

;; access to enum symbols and #define'd constants:
(define ffi-notmuch-symbol-tab
  '((NOTMUCH_DECRYPT_NOSTASH . 3)
    (NOTMUCH_DECRYPT_AUTO . 2)
    (NOTMUCH_DECRYPT_TRUE . 1)
    (NOTMUCH_DECRYPT_FALSE . 0)
    (NOTMUCH_DECRYPT_NOSTASH . 3)
    (NOTMUCH_DECRYPT_AUTO . 2)
    (NOTMUCH_DECRYPT_TRUE . 1)
    (NOTMUCH_DECRYPT_FALSE . 0)
    (NOTMUCH_MESSAGE_FLAG_GHOST . 2)
    (NOTMUCH_MESSAGE_FLAG_EXCLUDED . 1)
    (NOTMUCH_MESSAGE_FLAG_MATCH . 0)
    (NOTMUCH_MESSAGE_FLAG_GHOST . 2)
    (NOTMUCH_MESSAGE_FLAG_EXCLUDED . 1)
    (NOTMUCH_MESSAGE_FLAG_MATCH . 0)
    (NOTMUCH_EXCLUDE_ALL . 3)
    (NOTMUCH_EXCLUDE_FALSE . 2)
    (NOTMUCH_EXCLUDE_TRUE . 1)
    (NOTMUCH_EXCLUDE_FLAG . 0)
    (NOTMUCH_EXCLUDE_ALL . 3)
    (NOTMUCH_EXCLUDE_FALSE . 2)
    (NOTMUCH_EXCLUDE_TRUE . 1)
    (NOTMUCH_EXCLUDE_FLAG . 0)
    (NOTMUCH_SORT_UNSORTED . 3)
    (NOTMUCH_SORT_MESSAGE_ID . 2)
    (NOTMUCH_SORT_NEWEST_FIRST . 1)
    (NOTMUCH_SORT_OLDEST_FIRST . 0)
    (NOTMUCH_SORT_UNSORTED . 3)
    (NOTMUCH_SORT_MESSAGE_ID . 2)
    (NOTMUCH_SORT_NEWEST_FIRST . 1)
    (NOTMUCH_SORT_OLDEST_FIRST . 0)
    (NOTMUCH_DATABASE_MODE_READ_WRITE . 1)
    (NOTMUCH_DATABASE_MODE_READ_ONLY . 0)
    (NOTMUCH_DATABASE_MODE_READ_WRITE . 1)
    (NOTMUCH_DATABASE_MODE_READ_ONLY . 0)
    (NOTMUCH_STATUS_LAST_STATUS . 19)
    (NOTMUCH_STATUS_UNKNOWN_CRYPTO_PROTOCOL . 18)
    (NOTMUCH_STATUS_FAILED_CRYPTO_CONTEXT_CREATION
      .
      17)
    (NOTMUCH_STATUS_MALFORMED_CRYPTO_PROTOCOL . 16)
    (NOTMUCH_STATUS_ILLEGAL_ARGUMENT . 15)
    (NOTMUCH_STATUS_IGNORED . 14)
    (NOTMUCH_STATUS_PATH_ERROR . 13)
    (NOTMUCH_STATUS_UPGRADE_REQUIRED . 12)
    (NOTMUCH_STATUS_UNSUPPORTED_OPERATION . 11)
    (NOTMUCH_STATUS_UNBALANCED_ATOMIC . 10)
    (NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW . 9)
    (NOTMUCH_STATUS_TAG_TOO_LONG . 8)
    (NOTMUCH_STATUS_NULL_POINTER . 7)
    (NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID . 6)
    (NOTMUCH_STATUS_FILE_NOT_EMAIL . 5)
    (NOTMUCH_STATUS_FILE_ERROR . 4)
    (NOTMUCH_STATUS_XAPIAN_EXCEPTION . 3)
    (NOTMUCH_STATUS_READ_ONLY_DATABASE . 2)
    (NOTMUCH_STATUS_OUT_OF_MEMORY . 1)
    (NOTMUCH_STATUS_SUCCESS . 0)
    (NOTMUCH_STATUS_LAST_STATUS . 19)
    (NOTMUCH_STATUS_UNKNOWN_CRYPTO_PROTOCOL . 18)
    (NOTMUCH_STATUS_FAILED_CRYPTO_CONTEXT_CREATION
      .
      17)
    (NOTMUCH_STATUS_MALFORMED_CRYPTO_PROTOCOL . 16)
    (NOTMUCH_STATUS_ILLEGAL_ARGUMENT . 15)
    (NOTMUCH_STATUS_IGNORED . 14)
    (NOTMUCH_STATUS_PATH_ERROR . 13)
    (NOTMUCH_STATUS_UPGRADE_REQUIRED . 12)
    (NOTMUCH_STATUS_UNSUPPORTED_OPERATION . 11)
    (NOTMUCH_STATUS_UNBALANCED_ATOMIC . 10)
    (NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW . 9)
    (NOTMUCH_STATUS_TAG_TOO_LONG . 8)
    (NOTMUCH_STATUS_NULL_POINTER . 7)
    (NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID . 6)
    (NOTMUCH_STATUS_FILE_NOT_EMAIL . 5)
    (NOTMUCH_STATUS_FILE_ERROR . 4)
    (NOTMUCH_STATUS_XAPIAN_EXCEPTION . 3)
    (NOTMUCH_STATUS_READ_ONLY_DATABASE . 2)
    (NOTMUCH_STATUS_OUT_OF_MEMORY . 1)
    (NOTMUCH_STATUS_SUCCESS . 0)
    (NOTMUCH_TAG_MAX . 200)
    (LIBNOTMUCH_MICRO_VERSION . 0)
    (LIBNOTMUCH_MINOR_VERSION . 3)
    (LIBNOTMUCH_MAJOR_VERSION . 5)
    (TRUE . 1)
    (FALSE . 0)))

(define ffi-notmuch-symbol-val
  (lambda (k)
    (or (assq-ref ffi-notmuch-symbol-tab k))))
(export ffi-notmuch-symbol-val)

(define (unwrap-enum obj)
  (cond ((number? obj) obj)
        ((symbol? obj) (ffi-notmuch-symbol-val obj))
        ((fh-object? obj) (struct-ref obj 0))
        (else (error "type mismatch"))))

(define ffi-notmuch-types
  '((pointer . "notmuch_database_t") "notmuch_database_t" (pointer . 
    "notmuch_query_t") "notmuch_query_t" (pointer . "notmuch_threads_t") 
    "notmuch_threads_t" (pointer . "notmuch_thread_t") "notmuch_thread_t" 
    (pointer . "notmuch_messages_t") "notmuch_messages_t" (pointer . 
    "notmuch_message_t") "notmuch_message_t" (pointer . "notmuch_tags_t") 
    "notmuch_tags_t" (pointer . "notmuch_directory_t") "notmuch_directory_t" 
    (pointer . "notmuch_filenames_t") "notmuch_filenames_t" (pointer . 
    "notmuch_config_list_t") "notmuch_config_list_t" (pointer . 
    "notmuch_indexopts_t") "notmuch_indexopts_t" "notmuch_compact_status_cb_t"
    (pointer . "notmuch_message_properties_t") "notmuch_message_properties_t"))
(export ffi-notmuch-types)

;; --- last line ---
