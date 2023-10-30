(define-module (anon features base)
  #:use-module (rde features)
  #:use-module ((rde features base) #:prefix rde:)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages admin)
  #:use-module (anon packages rust-apps)
  #:use-module (guix gexp)
  #:export (feature-base-services))

(define* (feature-base-services
          #:key
          default-substitute-urls
          guix-substitute-urls
          guix-authorized-keys
          (tuigreet? #f))
  "Use @code{tuigreet} instead of @code{agreety} as terminal ui greeter for greetd."
  (define base (rde:feature-base-services
                #:default-substitute-urls default-substitute-urls
                #:guix-substitute-urls guix-substitute-urls
                #:guix-authorized-keys guix-authorized-keys))

  (define (get-system-services config)
    (modify-services ((feature-system-services-getter base) config)
                     (greetd-service-type
                      config =>
                      (greetd-configuration
                       (terminals
                        (map (lambda (x)
                               (greetd-terminal-configuration
                                (terminal-vt (number->string x))
                                (default-session-command
                                  (program-file
                                   "run-greeter"
                                   #~(execl #$(file-append ddlm "/bin/ddlm")
                                            #$(file-append ddlm "/bin/ddlm")
                                            "--target"
                                            #$(file-append bash "/bin/bash"))))))
                             (iota 6 1)))
                       (greeter-supplementary-groups
                        '("video"))))))

  (feature
   (name (feature-name base))
   (values (feature-values base))
   (system-services-getter get-system-services)
   (home-services-getter
    (feature-home-services-getter base))))
