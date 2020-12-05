(define-module (utils)
  #:export (-> ->> expand-file))

(define-syntax ->
  (syntax-rules ()
    ((_ value) value)
    ((_ value (f1 . body) next ...) (-> (f1 value . body) next ...))
    ((_ value fun next ...) (-> (fun value) next ...))))

(define-syntax ->>
  (syntax-rules ()
    ((_ value) value)
    ((_ value (f ...) rest ...) (->> (f ... value) rest ...))
    ((_ value f rest ...) (->> (f value) rest ...))))

(define (expand-file f)
  ;; https://irreal.org/blog/?p=83
  (cond ((char=? (string-ref f 0) #\/) f)
        ((string=? (substring f 0 2) "~/")
         (let ((prefix (passwd:dir (getpwuid (geteuid)))))
           (string-append prefix (substring f 1 (string-length f)))))
        ((char=? (string-ref f 0) #\~)
         (let* ((user-end (string-index f #\/))
                (user (substring f 1 user-end))
                (prefix (passwd:dir (getpwnam user))))
           (string-append prefix (substring f user-end (string-length f)))))
        (else (string-append (getcwd) "/" f))))
