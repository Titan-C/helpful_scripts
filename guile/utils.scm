(define-module (utils)
  #:export (-> ->>))

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
