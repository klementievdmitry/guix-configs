(use-modules
 (gnu)
 (gnu home services)
 (gnu packages chromium)
 (gnu packages suckless)
 (gnu packages emacs)
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
 (rde features keyboard)
 (rde features networking)
 (rde features web-browsers)
 (rde features nyxt-xyz)
 (rde features fontutils)
 (contrib features wm)
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

(define %xorg-libinput-configuration
  "Section \"InputClass\"
  Identifier \"Touchpads\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsTouchpad \"on\"
  Option \"Tapping\" \"on\"
  Option \"TappingDrag\" \"on\"
  Option \"DisableWhileTyping\" \"on\"
  Option \"MiddleEmulation\" \"on\"
  Option \"ScrollMethdod\" \"twofinger\"
  Option \"NaturalScrolling\" \"true\"
EndSection
Section \"InputClass\"
  Identifier \"Keyboards\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsKeyboard \"on\"
EndSection")

(define %my-features
  (append
   ;; Host-specific features
   (get-host-features)
   (list
    (feature-user-info
     #:user-name "anon"
     #:full-name "Anonymous"
     #:email "klementievdmitry@gmail.com"
     #:user-groups
     '("wheel"
       "netdev"
       "audio"
       "video"
       "dialout"
       "tty"))
    (feature-base-packages
     #:home-packages
     ;; TODO: Use `surf' as a main web browser in EXWM.
     ;; TODO: Maybe setup `luakit' or `nyxt' as main web browser in all sessions
     (list surf ungoogled-chromium))
    (feature-base-services
     #:default-substitute-urls
     '("https://bordeaux.guix.gnu.org")
     #:guix-substitute-urls
     '("https://substitutes.nonguix.org")
     #:guix-authorized-keys
     (list (local-file "./signing-key.pub")))
    (feature-desktop-services)
    (feature-networking)
    (feature-flatpak
     #:packages (list flatpak-discord))
    (feature-xdg)
    (feature-bluetooth)
    (feature-keyboard
     #:keyboard-layout
     my-keyboard-layout)

    (feature-fonts)

    (feature-emacs
     #:emacs emacs)
    (feature-emacs-appearance
     #:margin 0
     #:header-line-as-mode-line? #f)
    (feature-emacs-eshell)
    (feature-vterm)
    (feature-emacs-all-the-icons)
    (feature-emacs-completion)
    (feature-emacs-vertico)
    (feature-emacs-corfu)
    (feature-emacs-eglot)
    (feature-emacs-flymake)
    (feature-emacs-elisp)
    (feature-emacs-git)
    (feature-emacs-geiser)
    (feature-emacs-guix)
    (feature-emacs-pdf-tools)
    (feature-emacs-org)
    (feature-emacs-telega
     #:notify? #t)
    (feature-emacs-battery)
    (feature-emacs-ednc
     #:notifications-icon #f)
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

    (feature-emacs-exwm)
    (feature-emacs-exwm-run-on-tty
     #:xorg-libinput-configuration %xorg-libinput-configuration
     #:emacs-exwm-tty-number 1)
    )))

(let ((%config (rde-config
                (features %my-features))))
  (match (getenv "RDE_TARGET")
    ("home" (rde-config-home-environment %config))
    ("system" (rde-config-operating-system %config))
    (_ (rde-config-operating-system %config))))
