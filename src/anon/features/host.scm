(define-module (anon features host)
  #:use-module (gnu system file-systems)
  #:use-module (rde features system)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (guix records)
  #:use-module (ice-9 rdelim)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:export (get-host-features))

(define-record-type* <host>
  host make-host
  host?
  this-host
  (name host-name)
  (efi host-efi)
  (root host-root)
  (firmware host-firmware
            (default
              (list
               linux-firmware)))
  (kernel-arguments host-kernel-arguments
                    (default '())))

(define %hosts
  (list
   (host (name "Aspire A315-23G")
         (efi "/dev/nvme0n1p1")
         (root "/dev/nvme0n1p2")
         (firmware (list atheros-firmware
                         amdgpu-firmware
                         radeon-firmware))
         (kernel-arguments
          '("nvme_core.default_ps_max_latency_us=0")))))

;; TODO: Add `low-memory?' field to <host>. If low-memory? true then add `feature-emacs-low-memory'.
(define (get-host-features)
  "Get host-specific features like efi, root, firmware and kernel arguments."

  (define (get-host-name)
    (call-with-input-file "/sys/devices/virtual/dmi/id/product_name"
      read-line))

  (define (current-host? local-host)
    (if (string= (host-name local-host) (get-host-name))
        local-host
        #f))

  (define %current-host
    (car (filter-map current-host? %hosts)))

  (define home-fs
    (file-system
     (type "btrfs")
     (device (host-root %current-host))
     (mount-point "/home")
     (options "autodefrag,compress=zstd,subvol=home")))

  (define get-btrfs-file-system
    (match-lambda
      ((subvol . mount-point)
       (file-system
        (type "btrfs")
        (device (host-root %current-host))
        (mount-point mount-point)
        (options
         (format #f "~asubvol=~a"
                 (if (string=? "/swap" mount-point)
                     ""
                     "autodefrag,compress=zstd,")
                 subvol))
        (needed-for-boot? (or (string=? "/gnu/store" mount-point)
                              (string=? "/var/guix" mount-point)
                              (string=? "/boot" mount-point)))
        (dependencies (if (string-prefix? "/home/anon" mount-point)
                          (list home-fs)
                          '()))))))

  (define %impermanence-btrfs-file-systems
    (map get-btrfs-file-system
         '((store . "/gnu/store")
           (guix . "/var/guix")
           (log . "/var/log")
           (lib . "/var/lib")
           (boot . "/boot"))))

  (define %additional-btrfs-file-systems
    (map get-btrfs-file-system
         '((btrbk_snapshots . "/btrbk_snapshots")
           (projects . "/home/anon/projects")
           (areas . "/home/anon/areas")
           (resources . "/home/anon/resources")
           (archives . "/home/anon/archives")
           ;; FIXME: This causes following error on `guix home reconfigure':
           ;;        `guix home: error: rmdir: Device or resource busy'
           ;; (local . "/home/anon/.local")
           (cache . "/home/anon/.cache"))))

  (define swap-fs (get-btrfs-file-system '(swap . "/swap")))

  (define btrfs-file-systems
    (append
     (list (file-system
            (type "btrfs")
            (device (host-root %current-host))
            (mount-point "/")
            (options "autodefrag,compress=zstd,subvol=root")
            (needed-for-boot? #t)))
     %impermanence-btrfs-file-systems
     (list home-fs)
     %additional-btrfs-file-systems
     (list (file-system
            (type "vfat")
            (device (host-efi %current-host))
            (mount-point "/boot/efi")
            (needed-for-boot? #t))
           swap-fs)))
  (list
   (feature-bootloader)
   (feature-file-systems
    #:mapped-devices '()
    #:swap-devices
    (list (swap-space (target "/swap/swapfile")
                      (dependencies (list swap-fs))))
    #:file-systems btrfs-file-systems)
   (feature-kernel
    #:kernel linux-xanmod
    #:initrd microcode-initrd
    #:initrd-modules
    (append (list "vmd") (@ (gnu system linux-initrd) %base-initrd-modules))
    #:kernel-arguments
    (host-kernel-arguments %current-host)
    #:firmware (host-firmware %current-host))
   (feature-host-info
    #:host-name "gentoo"
    #:timezone "Asia/Yekaterinburg" ; or "Etc/UTC"
    #:locale "en_US.utf8"
    #:issue (@@ (gnu system) %default-issue))))
