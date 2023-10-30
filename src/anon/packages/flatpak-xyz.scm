(define-module (anon packages flatpak-xyz)
  #:use-module (gnu services configuration)
  #:export (flatpak-package
            flatpak-package?
            flatpak-package-remote
            flatpak-package-id
            flatpak-package-filesystems))

;; TODO: Description of flatpak package.
;; TODO: Docstring about flatpak package definition.
(define-configuration/no-serialization flatpak-package
  (remote
   (symbol #f)
   "Flatpak remote.")
  (id
   (string #f)
   "Flatpak application id.")
  (filesystems
   (list '())
   "List of filesystems for application.
This runs a @code{flatpak override --filesystem=<FILESYSTEM> <APP_ID>}."))

;;;
;;; Flatpak packages.
;;;

(define-public flatpak-google-chrome
  (flatpak-package
   (remote 'flathub)
   (id "com.google.Chrome")
   (filesystems
    '("~/dl" "~/pics" "~/vids"))))

(define-public flatpak-steam
  (flatpak-package
   (remote 'flathub)
   (id "com.valvesoftware.Steam")))

(define-public flatpak-prism-launcher
  (flatpak-package
   (remote 'flathub)
   (id "org.prismlauncher.PrismLauncher")))

(define-public flatpak-discord
  (flatpak-package
   (remote 'flathub)
   (id "com.discordapp.Discord")
   (filesystems
    '("~/dl" "~/pics" "~/vids"))))

(define-public flatpak-zoom
  (flatpak-package
   (remote 'flathub)
   (id "us.zoom.Zoom")))

(define-public flatpak-pycharm-community
  (flatpak-package
   (remote 'flathub)
   (id "com.jetbrains.PyCharm-Community")
   (filesystems
    '("~/work"))))

(define-public flatpak-libreoffice
  (flatpak-package
   (remote 'flathub)
   (id "org.libreoffice.LibreOffice")
   (filesystems
    '("~/pics" "~/vids" "~/work" "~/docs"))))

(define-public flatpak-session-desktop
  (flatpak-package
   (remote 'flathub)
   (id "network.loki.Session")
   (filesystems
    '("~/pics" "~/vids"))))

(define-public flatpak-signal-desktop
  (flatpak-package
   (remote 'flathub)
   (id "org.signal.Signal")
   (filesystems
    '("~/pics" "~/vids"))))

(define-public flatpak-obs-studio
  (flatpak-package
   (remote 'flathub)
   (id "com.obsproject.Studio")
   (filesystems
    '("~/pics" "~/vids"))))

(define-public flatpak-element-desktop
  (flatpak-package
   (remote 'flathub)
   (id "im.riot.Riot")
   (filesystems
    '("~/pics" "~/vids"))))

(define-public flatpak-jami
  (flatpak-package
   (remote 'flathub)
   (id "net.jami.Jami")
   (filesystems
    '("~/pics" "~/vids"))))

(define-public flatpak-lonewolf
  (flatpak-package
   (remote 'flathub)
   (id "site.someones.Lonewolf")))

(define-public flatpak-calibre
  (flatpak-package
   (remote 'flathub)
   (id "com.calibre_ebook.calibre")))

(define-public flatpak-figma-linux
  (flatpak-package
   (remote 'flathub)
   (id "io.github.Figma_Linux.figma_linux")))

(define-public flatpak-qbittorrent
  (flatpak-package
   (remote 'flathub)
   (id "org.qbittorrent.qBittorrent")
   (filesystems
    '("~/dl"))))

(define-public flatpak-qflipper
  (flatpak-package
   (remote 'flathub)
   (id "one.flipperzero.qFlipper")
   (filesystems
    '("~/dl" "~/work"))))

(define-public flatpak-torbrowser-launcher
  (flatpak-package
   (remote 'flathub)
   (id "com.github.micahflee.torbrowser-launcher")
   (filesystems
    '("~/dl"))))
