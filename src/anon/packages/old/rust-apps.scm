(define-module (anon packages rust-apps)
  #:use-module (guix packages)
  #:use-module (guix build-system cargo)
  #:use-module (guix git-download)
  #:use-module (gnu packages crates-io)
  #:use-module (anon packages crates-io)
  #:use-module ((guix licenses) #:prefix license:))

(define-public tuigreet
  (package
   (name "tuigreet")
   (version "0.8.0")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/apognu/tuigreet")
                  (commit version)))
            (sha256
             (base32 "04pwp3xiv87nv6q4idzj5q1qc640a7gvh0jhcymg3xrnp7lqizgk"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-chrono" ,rust-chrono-0.4)
            ;;("rust-crossterm" ,rust-crossterm-0.24)
            ("rust-greetd-ipc" ,rust-greetd-ipc-0.8)
            ("rust-i18n" ,rust-i18n-0.2.10))
          ))
   (home-page "https://github.com/apognu/tuigreet")
   (description "Graphical console greeter for greetd.")
   (synopsis "Graphical console greeter for greetd.")
   (license license:gpl3)))

tuigreet
