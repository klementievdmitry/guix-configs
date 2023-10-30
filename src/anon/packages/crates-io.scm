(define-module (anon packages crates-io)
  #:use-module (gnu packages crates-io)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

(define* (crate-home-page
          name
          #:optional
          (version ""))
  (string-append
   "https://crates.io/crates/"
   name "/" version))

(define-public rust-bmp-0.1
  (package
   (name "rust-bmp")
   (version "0.1.4")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "bmp" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0aqgksc2w754y3bq7d8l0izwls92xhwcqibqlh0d66612hcry361"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-byteorder-1" ,rust-byteorder-1))))
   (home-page (crate-home-page "bmp" version))
   (synopsis "Small module for reading and writing bitmap images.")
   (description
    "A small library for reading and writing BMP images.

The library supports uncompressed BMP Version 3 images.")
   (license license:expat)))

(define-public rust-framebuffer-0.3
  (package
   (name "rust-framebuffer")
   (version "0.3.1")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "framebuffer" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0jgi9slvmajy2hgf3f2bmhyr2zp06c4zkvn6gmq9yb5r3fpsm347"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-errno-0.2" ,rust-errno-0.2)
            ("rust-libc-0.2" ,rust-libc-0.2)
            ("rust-memmap-0.7" ,rust-memmap-0.7))
          #:cargo-development-inputs
          `(("rust-rand-0.6" ,rust-rand-0.6)
            ("rust-bmp-0.1" ,rust-bmp-0.1))))
   (home-page (crate-home-page "framebuffer"))
   (synopsis "Basic framebuffer abstraction for Rust.")
   (description
    "Simple linux framebuffer abstraction.")
   ;; WTFPL or WTFPL2 ???
   (license license:wtfpl2)))

(define-public rust-pam-0.7
  (package
   (name "rust-pam")
   (version "0.7.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "pam" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "15rhp57pdb54lcx37vymcimimpd1ma90lhm10iq08710kjaxqazs"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-libc-0.2" ,rust-libc-0.2)
            ("rust-pam-sys-0.5" ,rust-pam-sys-0.5)
            ("rust-users-0.11" ,rust-users-0.11)
            ("rust-rpassword-4" ,rust-rpassword-4))))
   (home-page (crate-home-page "pam"))
   (synopsis "Safe Rust bindings to PAM.")
   (description
    "Safe Rust bindings to Linux Pluggable Authentication Modules (PAM). Currently only supports basic username/password authentication out-of-the-box.")
   (license license:expat)))

(define-public rust-osstrtools-0.2
  (package
   (name "rust-osstrtools")
   (version "0.2.2")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "osstrtools" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1fna5n3b6237dsp6cm8wi07v44iw6azxhryks9wbhfpfkvddla7k"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-itertools-0.8" ,rust-itertools-0.8)
            ("rust-os-str-bytes-2" ,rust-os-str-bytes-2))))
   (home-page (crate-home-page "osstrtools"))
   (synopsis "Additional helper methods for OsStr")
   (description
    "@code{OsStrTools} adds some useful methods to @code{OsStr} and @code{OsString} that are missing in the standard library, like @code{split()},
@code{replace()}, or @code{splice()}. It is mostly useful for dealing dealing with things like file names, command line arguments, @code{PathBuf}, and the like.

Windows support is experimental, but shoud hopefully mostly work, although it is not well tested and likely somewhat slower due to some overhead since
it requires checking the strings for correctness. The checking is done by @code{os_str_bytes.}")
   (license license:wtfpl2)))

(define-public rust-freedesktop-desktop-entry-0.5
  (package
   (name "rust-freedesktop-desktop-entry")
   (version "0.5.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "freedesktop-desktop-entry" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0abdzj05yy7hjhdxb6yvfa7mzbvqdc5l70j3b4zizs15lxsp25a5"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-dirs-3" ,rust-dirs-3)
            ("rust-gettext-rs-0.7" ,rust-gettext-rs-0.7)
            ("rust-memchr-2" ,rust-memchr-2)
            ("rust-thiserror-1" ,rust-thiserror-1)
            ("rust-xdg-2" ,rust-xdg-2))))
   (home-page (crate-home-page "freedesktop-desktop-entry"))
   (synopsis "Freedesktop Desktop Entry Specification")
   (description
    "This crate provides a library for efficiently parsing Desktop Entry files.")
   (license license:mpl2.0)))

(define-public rust-termion-1.5.6
  (package
   (inherit rust-termion-1)
   (name "rust-termion")
   (version "1.5.6")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "termion" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0zk023f0zkws358ll399cawvwdnd0wg8wad4g61kz766xbi8aw87"))))))

(define-public rust-users-0.8
  (package
   (inherit rust-users-0.11)
   (name "rust-users")
   (version "0.8.1")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "users" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1dss2l4x3zgjq26mwa97aa5xmsb5z2x3vhhhh3w3azan284pvvbz"))))))
