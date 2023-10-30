(define-module (anon features console-font)
  #:use-module (rde features)
  #:export (feature-console-font))

(define* (feature-console-font
          #:key
          console-font)
  (feature
   (name 'console-font)
   (values `((console-font . ,console-font)))))
