(define-module (anon home services package-management)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (gnu packages package-management)
  #:use-module (anon packages flatpak-xyz)
  #:use-module (guix packages)
  #:use-module (guix i18n)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:export (home-flatpak-configuration
            home-flatpak-configuration?
            home-flatpak-service-type))

(define list-of-flatpak-packages? (list-of flatpak-package?))

(define-public flatpak-default-remote-link
  "https://dl.flathub.org/repo/flathub.flatpakrepo")

(define (member-of? k lst)
  "Are K member of LST?"
  (if (boolean? (member k lst))
      #f #t))

(define-configuration/no-serialization home-flatpak-configuration
  (flatpak
   (package flatpak)
   "The Flatpak package to use.")
  (remotes
   (alist `((flathub . ,flatpak-default-remote-link)))
   "A list of flatpak remotes.")
  (packages
   (list-of-flatpak-packages '())
   "A list of flatpak packages."))

(define (flatpak-require-remote remote-name config)
  "This procedure should be used for pretty error and debug
messages, but now it prints so bad error message without things like name of remote."
  (let ((remotes (map (lambda (x) (car x)) home-flatpak-configuration-remotes config)))
    (when (not (member-of? remote-name remotes))
      (raise (formatted-message
              (G_ "No required remote in Flatpak."))))))

(define (flatpak-packages config)
  "Returns Flatpak package for Home Profile."
  (list (home-flatpak-configuration-flatpak config)))

(define (flatpak-packages-installer config)
  "Returns G-exp which install, update and configure Flatpak applications."
  #~(unless (getenv "GUIX_FLATPAK_DISABLE")
      (let ((flatpak (string-append
                      #$(home-flatpak-configuration-flatpak config)
                      "/bin/flatpak"))
            (packages '#$(map (lambda (pkg)
                                `(,(flatpak-package-id pkg)
                                  ,(flatpak-package-remote pkg)
                                  ,(flatpak-package-filesystems pkg)))
                              (home-flatpak-configuration-packages config)))
            (remotes '#$(home-flatpak-configuration-remotes config)))
        ;; Setup remotes
        (for-each
         (lambda (remote)
           (let ((name (car remote))
                 (url (cdr remote)))
             (invoke flatpak
                     "--user"
                     "remote-add"
                     "--if-not-exists"
                     (symbol->string name)
                     url)))
         remotes)

        ;; Install/update/setup applications in profile
        (for-each
         (lambda (pkg)
           (let ((remote (list-ref pkg 1))
                 (app-id (list-ref pkg 0))
                 (filesystems (list-ref pkg 2)))
             ;; (flatpak-require-remote remote config)
             (invoke flatpak
                     "--user"
                     "install"
                     "--or-update"
                     "--noninteractive"
                     (symbol->string remote)
                     app-id)
             (for-each ; Setup filesystems for application
              (lambda (fs)
                (invoke flatpak
                        "--user"
                        "override"
                        (string-append
                         "--filesystem=" fs)
                        app-id))
              filesystems)))
         packages)
        (invoke flatpak
                "--user"
                "update"
                "--noninteractive"))))

(define home-flatpak-service-type
  (service-type (name 'flatpak)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        flatpak-packages)
                       (service-extension
                        home-activation-service-type
                        flatpak-packages-installer)))
                (compose concatenate)
                (description "Install and configure Flatpak applications.")
                (default-value (home-flatpak-configuration))))

(define-public %my-flatpak-services
  (list (service home-flatpak-service-type
                 (home-flatpak-configuration
                  (packages
                   (list
                    flatpak-google-chrome
                    flatpak-discord
                    flatpak-steam
                    flatpak-qbittorrent
                    flatpak-qflipper))))))
