(define-module (anon serializers toml)
  #:use-module (guix gexp)
  #:export ())

(define (toml-config? config)
  (list? config))

(define (toml-serialize config)
  #f)
