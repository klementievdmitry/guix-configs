(define-module (anon features nyxt-xyz)
  #:use-module (rde features)
  #:use-module (rde home services web-browsers)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:export (feature-nyxt-emacs-mode))

(define* (feature-nyxt-emacs-mode)
  (define nyxt-f-name 'emacs-mode)
  (define f-name (symbol-append 'nyxt- nyxt-f-name))

  (define (get-home-services config)
    (list
     (service (make-nyxt-service-type f-name)
              (home-nyxt-lisp-configuration
               (name nyxt-f-name)
               (config
                `((define-configuration buffer
                    ((default-modes
                       (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))))))))

  (feature
   (name f-name)
   (values `((,f-name . #t)))
   (home-services-getter get-home-services)))
