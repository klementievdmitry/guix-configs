(use-modules
 (gnu)
 (gnu home services shells)
 (rde features)
 ((rde features base)
  #:select (feature-user-info
            feature-base-packages
            feature-custom-services
            feature-desktop-services
            feature-hidpi
            feature-generic
            feature-foreign-distro
            %rde-default-substitute-urls
            %rde-default-authorized-guix-keys))
 (rde features emacs)
 (rde features emacs-xyz)
 (rde features python)
 (rde features terminals)
 (rde features bluetooth)
 (rde features xdg)
 (rde features wm)
 (rde features keyboard)
 (rde features networking)
 (rde features web-browsers)
 (rde features nyxt-xyz)
 (anon features host)
 (anon features emacs-xyz)
 (anon features flatpak)
 (anon features nyxt-xyz)
 (anon features console-font)
 (anon features base)
 (anon packages flatpak-xyz)
 (ice-9 match))

(use-package-modules
 wm fonts)

(use-package-modules
 gnuzilla)

(use-service-modules
 desktop xorg networking)

(define my-keyboard-layout
  (keyboard-layout
   "us,ru"
   #:options
   '("caps:escape"
     "grp:shifts_toggle")))

(define substitute-urls
  '("https://bordeaux.guix.gnu.org"
    "https://substitutes.nonguix.org"))

(define %my-features
  (append
   ;; Host-specific features
   (get-host-features)
   (list
    (feature-user-info
     #:user-name "anon"
     #:full-name "Anonymous"
     #:email "klementievdmitry@gmail.com")
    (feature-base-packages
     #:home-packages
     (list icecat))
    (feature-base-services
     #:default-substitute-urls
     '("https://bordeaux.guix.gnu.org")
     #:guix-substitute-urls
     '("https://substitutes.nonguix.org")
     #:guix-authorized-keys
     (list (local-file "./signing-key.pub")))
    (feature-desktop-services)
    (feature-networking)
    (feature-custom-services
     #:home-services
     '())
    (feature-flatpak
     #:packages (list flatpak-discord))
    (feature-xdg)
    (feature-bluetooth)
    (feature-keyboard
     #:keyboard-layout
     my-keyboard-layout)
    (feature-emacs)
    (feature-emacs-appearance
     #:margin 0
     #:header-line-as-mode-line? #f)
    (feature-emacs-eshell)
    (feature-vterm)
    (feature-emacs-vertico)
    (feature-emacs-which-key)
    (feature-emacs-smartparens)
    (feature-emacs-doom-themes)
    (feature-emacs-doom-modeline)

    (feature-console-font
     #:console-font
     (file-append font-tamzen
                  "/share/kbd/consolefonts/TamzenForPowerline10x20.psf"))

    (feature-python)

    (feature-nyxt)
    (feature-nyxt-emacs-mode)

    (feature-sway
     #:extra-config
     '((input * ((tap enabled)
                 (natural_scroll enabled)))))
    (feature-sway-run-on-tty)
    (feature-waybar
     #:waybar waybar))))

(let ((%config (rde-config
                (features %my-features))))
  (match (getenv "RDE_TARGET")
    ("home" (rde-config-home-environment %config))
    ("system" (rde-config-operating-system %config))
    (_ (rde-config-operating-system %config))))
