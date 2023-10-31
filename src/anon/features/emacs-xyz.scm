(define-module (anon features emacs-xyz)
  #:use-module (rde features)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (guix gexp)
  #:export (feature-emacs-wttr
            feature-emacs-doom-themes
            feature-emacs-doom-modeline))

(define* (feature-emacs-doom-themes
          #:key
          (light-theme 'one-light)
          (dark-theme 'one))
  (ensure-pred symbol? light-theme)
  (ensure-pred symbol? dark-theme)

  (define emacs-f-name 'doom-themes)
  (define f-name (symbol-append 'emacs- emacs-f-name))

  (define (get-home-services config)
    (list
     (rde-elisp-configuration-service
      emacs-f-name
      config
      `((require 'doom-themes)
        (with-eval-after-load
         'doom-themes
         (load-theme ',(symbol-append 'doom- light-theme) t)))
      #:elisp-packages (list emacs-doom-themes))))

  (feature
   (name f-name)
   (values `((,f-name . #t)))
   (home-services-getter get-home-services)))

(define (>0? n)
  (and (number? n)
       (> n 0)))

(define* (feature-emacs-doom-modeline
          #:key
          (modeline-height 25))
  (ensure-pred >0? modeline-height)

  (define emacs-f-name 'doom-modeline)
  (define f-name (symbol-append 'emacs- emacs-f-name))

  (define (get-home-services config)
    (list
     (rde-elisp-configuration-service
      emacs-f-name
      config
      `((require 'doom-modeline)
        (with-eval-after-load
         'doom-modeline
         (doom-modeline-mode 1)
         (setq doom-modeline-height ,modeline-height)))
      #:elisp-packages (list emacs-doom-modeline))))

  (feature
   (name f-name)
   (values `((,f-name . #t)))
   (home-services-getter get-home-services)))
