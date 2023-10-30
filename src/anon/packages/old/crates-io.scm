(define-module (anon packages crates-io)
  #:use-module (guix packages)
  #:use-module (guix build-system cargo)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (gnu packages crates-io)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-gettext-0.4
  (package
   (name "rust-gettext")
   (version "0.4.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "gettext" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0wd9kfy7nmbrqx2znw186la99as8y265lvh3pvj9fn9xfm75kfwy"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-byteorder" ,rust-byteorder-1)
            ("rust-encoding" ,rust-encoding-0.2))))
   (home-page "https://github.com/justinas/gettext")
   (description "Gettext for Rust.")
   (synopsis "Gettext for Rust.")
   (license license:expat)))

(define-public rust-arc-swap-1.6
  (package
   (inherit rust-arc-swap-1)
   (name "rust-arc-swap")
   (version "1.6.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "arc-swap" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "19n9j146bpxs9phyh48gmlh9jjsdijr9p9br04qms0g9ypfsvp5x"))))))

(define-public rust-fluent-bundle-0.15
  (package
   (name "rust-fluent-bundle")
   (version "0.15.2")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "fluent-bundle" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1zbzm13rfz7fay7bps7jd4j1pdnlxmdzzfymyq2iawf9vq0wchp2"))))
   (build-system cargo-build-system)
   (home-page "https://github.com/justinas/gettext")
   (description "Gettext for Rust.")
   (synopsis "Gettext for Rust.")
   (license license:expat)))

(define-public rust-fluent-0.16
  (package
   (name "rust-fluent")
   (version "0.16.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "fluent" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "19s7z0gw95qdsp9hhc00xcy11nwhnx93kknjmdvdnna435w97xk1"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-fluent-bundle-0.15" ,rust-fluent-bundle-0.15))))
   (home-page "https://crates.io/crates/fluent")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:asl2.0)))

(define-public rust-fluent-langneg-0.13
  (package
   (name "rust-fluent-langneg")
   (version "0.13.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "fluent-langneg" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "152yxplc11vmxkslvmaqak9x86xnavnhdqyhrh38ym37jscd0jic"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/fluent-langneg")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:asl2.0)))

(define-public rust-fluent-syntax-0.11
  (package
   (name "rust-fluent-syntax")
   (version "0.11.0")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "fluent-syntax" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0y6ac7z7sbv51nsa6km5z8rkjj4nvqk91vlghq1ck5c3cjbyvay0"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/fluent-syntax")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:asl2.0)))

(define-public rust-find-crate-0.6
  (package
   (name "rust-find-crate")
   (version "0.6.3")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "find-crate" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1ljpkh11gj7940xwz47xjhsvfbl93c2q0ql7l2v0w77amjx8paar"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/fluent-syntax")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:asl2.0)))

(define-public rust-i18n-embed-impl-0.8
  (package
   (name "rust-i18n-embed-impl")
   (version "0.8.2")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "i18n-embed-impl" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0yyhjwgzgbpf7s5ybqd4n153ld8v51ch0jcw8phsdja5yyzxb952"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-find-crate-0.6" ,rust-find-crate-0.6))))
   (home-page "https://crates.io/crates/i18n-embed-impl")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:expat)))

(define-public rust-intl-memoizer-0.5
  (package
   (name "rust-intl-memoizer")
   (version "0.5.1")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "intl-memoizer" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0vx6cji8ifw77zrgipwmvy1i3v43dcm58hwjxpb1h29i98z46463"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/i18n-embed-impl")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:expat)))

(define-public rust-rust-embed-6
  (package
   (inherit rust-rust-embed-5)
   (name "rust-rust-embed")
   (version "6.8.1")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "rust-embed" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0q96f3valahk4m4ir6c9vg45jhyalzn5iw90ijy4x33g4z1j8qm3"))))))

(define-public rust-tr-0.1
  (package
   (name "rust-tr")
   (version "0.1.7")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "tr" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0xksi7qq5h8i779ik51i81147858d5nxr3ng39pm47l9asg1s491"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/i18n-embed-impl")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:expat)))

(define-public rust-unic-langid-0.9
  (package
   (name "rust-unic-langid")
   (version "0.9.1")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "unic-langid" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "0byg9pqm4vywfx82lcw080sphbgj5z8niq0gz384zd4x4gbrm3rr"))))
   (build-system cargo-build-system)
   (home-page "https://crates.io/crates/i18n-embed-impl")
   (synopsis "TODO")
   (description
    "TODO")
   (license license:expat)))

(define-public rust-i18n-embed-0.13
  (package
   (name "rust-i18n-embed")
   (version "0.13.9")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "i18n-embed" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1ym19zhzdw52kkp45ilbf6pwbfkhzvjrwi13czg34rm1lwk65a4j"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `(("rust-arc-swap-1.6" ,rust-arc-swap-1.6)
            ("rust-fluent-0.16" ,rust-fluent-0.16)
            ("rust-fluent-langneg-0.13" ,rust-fluent-langneg-0.13)
            ("rust-fluent-syntax-0.11" ,rust-fluent-syntax-0.11)
            ("rust-gettext-0.4" ,rust-gettext-0.4)
            ("rust-i18n-embed-impl-0.8" ,rust-i18n-embed-impl-0.8)
            ("rust-intl-memoizer-0.5" ,rust-intl-memoizer-0.5)
            ("rust-locale-config-0.3" ,rust-locale-config-0.3)
            ("rust-rust-embed-6" ,rust-rust-embed-6)
            ("rust-tr-0.1" ,rust-tr-0.1)
            ("rust-unic-langid-0.9" ,rust-unic-langid-0.9))
          #:cargo-development-inputs
          `(("rust-doc-comment-0.3" ,rust-doc-comment-0.3)
            ("rust-env-logger-0.10" ,rust-env-logger-0.10)
            ("rust-maplit-1" ,rust-maplit-1)
            ("rust-pretty-assertions-1" ,rust-pretty-assertions-1)
            ("rust-serial-test-2" ,rust-serial-test-2))))
   (home-page "https://github.com/kellpossible/cargo-i18n")
   (synopsis "Internationalization library for Rust.")
   (description
    "Internationalization library for Rust.")
   (license license:expat)))

(define-public rust-i18n-embed-fl-0.6
  (package
   (name "rust-i18n-embed-fl")
   (version "0.6.7")
   (source (origin
            (method url-fetch)
            (uri (crate-uri "i18n-embed-fl" version))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "1kmzjz4asahrrjqzwk05d3wchw95x4i31shd11g7qywcx18f4jb9"))))
   (build-system cargo-build-system)
   (arguments
    (list #:cargo-inputs
          `()))
   (home-page "https://github.com/kellpossible/cargo-i18n")
   (synopsis "Internationalization library for Rust.")
   (description
    "Internationalization library for Rust.")
   (license license:expat)))

rust-i18n-embed-0.13
