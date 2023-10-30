(define-module (rde home services stumpwm)
  #:use-module (rde serializers lisp)
  #:use-module (gnu services)
  #:use-module (gnu services configuration)
  #:use-module (gnu home services)
  #:use-module (gnu packages wm)
  #:use-module (guix packages)
  ;; #:use-module (guix utils)
  #:use-module (guix gexp)
  ;; #:use-module (guix i18n)
  ;; #:use-module (guix diagnostics)
  #:use-module (srfi srfi-1)
  ;; #:use-module (srfi srfi-26)
  ;; #:use-module (ice-9 curried-definitions)
  ;; #:use-module (ice-9 pretty-print)
  #:use-module (ice-9 match)
  #:export (home-stumpwm-configuration
            home-stumpwm-extension
            home-stumpwm-service-type
            home-stumpwm-lisp-configuration
            home-stumpwm-lisp-extension
            make-stumpwm-service-type))

(define file-likes? (list-of file-like?))
(define list-of-symbols? (list-of symbol?))

(define serialize-file-likes empty-serializer)
(define serialize-boolean empty-serializer)
(define serialize-list empty-serializer)

(define (maybe-string? x)
  (or (string? x) (not x)))

(define-configuration home-stumpwm-configuration
  (stumpwm
   (package stumpwm)
   "StumpWM package to use.")
  (lisp-packages
   (file-likes '())
   "List of Lisp pacckages to install alongside the configuration.")
  (config-lisp
   (lisp-config '())
   "List of expressions, where each expression can be a Sexp or a Gexp.
Sexp is a Lisp form.  Strings don't require any conversion, but booleans do.
Sexps can contain file-like objects, which are paths to corresponding files in
the store that will be serialized as strings.  Gexps should be string-valued
and their value will be appended to the resulting Lisp file.

See @code{serialize-lisp-config} in the @code{(rde serializers lisp)} module
for more details on the Lisp serialization.

The list of expressions will be interposed with \n and everything will end up
in the @file{config.lisp}."))

(define-configuration home-stumpwm-extension
  (lisp-packages
   (file-likes '())
   "List of Lisp packages to install.")
  (config-lisp
   (lisp-config '())
   "List of expressions, each expression can be a S-exp or G-exp."))

(define (home-stumpwm-files-service config)
  (define (filter-fields field)
    (filter-configuration-fields home-stumpwm-configuration-fields
                                 (list field)))

  (define (serialize-field field)
    (serialize-configuration
     config
     (filter-fields field)))

  (if (null? (home-stumpwm-configuration-config-lisp config))
      '()
      (list
       `(".stumpwmrc"
         ,(mixed-text-file
           "stumpwmrc"
           (serialize-field 'config-lisp))))))

(define (home-stumpwm-extensions original-config extensions-config)
  (let ((extensions (reverse extensions-config)))
    (home-stumpwm-configuration
     (inherit original-config)
     (lisp-packages
      (append (home-stumpwm-configuration-lisp-packages original-config)
              (append-map
               home-stumpwm-extension-lisp-packages extensions)))
     (config-lisp
      (append (home-stumpwm-configuration-config-lisp original-config)
              (append-map
               home-stumpwm-extension-config-lisp extensions))))))

(define (home-stumpwm-profile-service config)
  (list (home-stumpwm-configuration-stumpwm config)))

(define home-stumpwm-service-type
  (service-type (name 'home-stumpwm)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        home-stumpwm-profile-service)
                       (service-extension
                        home-files-service-type
                        home-stumpwm-files-service)))
                (compose identity)
                (extend home-stumpwm-extensions)
                (default-value (home-stumpwm-configuration))
                (description "Install and configure StumpWM, \"everything-and-the-kitchen-sink WM\"
or \"the Emacs of WMs\".")))

;;;
;;; StumpWM configuration.
;;;

(define-configuration/no-serialization home-stumpwm-lisp-configuration
  (name
   (symbol #f)
   "The name of the configuration package.")
  (config
   (lisp-config '())
   "List of Lisp expressions. See
@code{home-stumpwm-service-type} for more information")
  (lisp-packages
   (list '())
   "List of additional Lisp packages to install alongside the configuration
package."))

(define-configuration/no-serialization home-stumpwm-lisp-extension
  (config
   (lisp-config '())
   "List of expressions.  See
@code{home-nyxt-service-type} for more information.")
  (lisp-packages
   (list '())
   "List of additional Lisp packages."))

(define (home-stumpwm-lisp-extensions original-config extensions)
  (let ((extensions (reverse extensions)))
    (home-stumpwm-lisp-configuration
     (inherit original-config)
     (config
      (append (home-stumpwm-lisp-configuration-config original-config)
              (append-map
               home-stumpwm-lisp-extension-config extensions)))
     (lisp-packages
      (append (home-stumpwm-lisp-configuration-lisp-packages original-config)
              (append-map
               home-stumpwm-lisp-extension-config extensions))))))

(define add-stumpwm-lisp-configuration
  (match-lambda
    (($ <home-stumpwm-lisp-configuration> name config lisp-packages)
     (let* ((file-name (symbol->string name))
            (conf-file (mixed-text-file
                        (string-append file-name ".lisp")
                        (serialize-lisp-config
                         #f
                         `((in-package :stumpwm)
                           ,@config))))
            (dirname #~(string-append (dirname #$conf-file) "/"))
            (filename #~(basename #$conf-file)))
       (home-stumpwm-extension
        (config-lisp
         `(,#~(string-trim-right
               (with-output-to-string
                 (lambda ()
                   ((@ (ice-9 pretty-print) pretty-print)
                    `(load ,#$(string-append dirname filename))))))
              #\newline))
        (lisp-packages lisp-packages))))))

(define (make-stumpwm-service-type name)
  (service-type (name name)
                (extensions
                 (list (service-extension
                        home-stumpwm-service-type
                        add-stumpwm-lisp-configuration)))
                (compose identity)
                (extend home-stumpwm-lisp-extensions)
                (default-value #f)
                (description (format #f "\
Create stumpwm-~a configuration file which extends StumpWM and ensures the provided
configuration is available/loaded at startup time. Can be extended with
@code{home-stumpwm-lisp-extension}." name))))
