(define-module (anon packages rust-apps)
  #:use-module (gnu packages crates-io)
  #:use-module (anon packages crates-io)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

(define-public carguix
  (package
   (name "carguix")
   (version "adc9b610ccc766854d988caec076eaaaa1b64be9")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/lelongg/carguix")
                  (commit version)))
            (sha256
             (base32 "0aqgksc2w754y3bq7d8l0izwls92xhwcqibqlh0d66612hcry362"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-cargo-toml-0.13" ,rust-cargo-toml-0.13)
            ("rust-structopt-0.2" ,rust-structopt-0.2) ; TODO
            ("rust-lexpr-0.2" ,rust-lexpr-0.2) ; TODO
            ("rust-crates-index-0.13" ,rust-crates-index-0.13) ; 0.13.1 -> 0.13.2
            ("rust-semver-0.9" ,rust-semver-0.9)
            ("rust-log-0.4" ,rust-log-0.4)
            ("rust-heck-0.3" ,rust-heck-0.3) ; 0.3.2 -> 0.3.1
            ("rust-shellfn-0.1" ,rust-shellfn-0.1) ; TODO
            ("rust-tempdir-0.3" ,rust-tempdir-0.3)
            ("rust-once-cell-1" ,rust-once-cell-1) ; 1.18.0 -> 1.16.0
            ("rust-reqwest-0.9" ,rust-reqwest-0.9) ; TODO 0.10.10 -> 0.9.20
            ("rust-env-logger-0.6" ,rust-env-logger-0.6)
            ("rust-rustbreak-1" ,rust-rustbreak-1) ; TODO
            ("rust-err-derive-0.3" ,rust-err-derive-0.3))))
   (home-page "https://github.com/lelongg/carguix")
   (synopsis "Generates definition for Rust crates.")
   (description
    "This tool generates Guix package definition for Rust crates from crates.io.")
   (license license:isc)))

(define-public ddlm
  (package
   (name "ddlm")
   (version "d8d1b2478bb3be6b9c2bb8082528a49fb9ea7d03")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/deathowl/ddlm")
                  (commit version)))
            (sha256
             (base32 "0aqgksc2w754y3bq7d8l0izwls92xhwcqibqlh0d66612hcry36q"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-byteorder-1" ,rust-byteorder-1)
            ("rust-chrono-0.4" ,rust-chrono-0.4)
            ("rust-rusttype-0.9" ,rust-rusttype-0.9)
            ("rust-nix-0.24" ,rust-nix-0.24)
            ("rust-memmap-0.7" ,rust-memmap-0.7)
            ("rust-lazy-static-1" ,rust-lazy-static-1)
            ("rust-termion-1.5.6" ,rust-termion-1.5.6)
            ("rust-users-0.8" ,rust-users-0.8)
            ("rust-greetd-ipc-0.8" ,rust-greetd-ipc-0.8)
            ("rust-getopts-0.2" ,rust-getopts-0.2)
            ("rust-hostname-0.3" ,rust-hostname-0.3)
            ("rust-thiserror-1" ,rust-thiserror-1)
            ("rust-shell-words-1" ,rust-shell-words-1)
            ("rust-freedesktop-desktop-entry-0.5" ,rust-freedesktop-desktop-entry-0.5)
            ("rust-framebuffer-0.3" ,rust-framebuffer-0.3)
            ("rust-pam-0.7" ,rust-pam-0.7)
            ("rust-osstrtools-0.2" ,rust-osstrtools-0.2))))
   (home-page "https://github.com/deathowl/ddlm")
   (synopsis "Deathowl's dummy login manager")
   (description
    "A stupidly simple graphical login manager. Uses framebuffer, so You wont have to run a wayland session to bootstrap your wayland session (unlike gtkgreet)

This is a greetd frontend.")
   (license license:gpl3)))

carguix
