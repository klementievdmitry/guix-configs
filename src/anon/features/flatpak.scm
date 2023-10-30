(define-module (anon features flatpak)
  #:use-module (rde features)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (anon home services package-management)
  #:export (feature-flatpak))

(define* (feature-flatpak
          #:key
          (packages '()))
  "Install flatpak packages."
  (ensure-pred list? packages)

  (define f-name 'flatpak)

  (define (get-home-services config)
    (list
     (service
      home-flatpak-service-type
      (home-flatpak-configuration
       (packages packages)))
     (simple-service
      'fix-flatpak-export-xdg-data-dirs
      home-environment-variables-service-type
      '(("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share")))
     ))

  (feature
   (name f-name)
   (values `((,f-name . #t)))
   (home-services-getter get-home-services)))
