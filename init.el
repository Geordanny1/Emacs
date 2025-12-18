(let ((file-name-handler-alist-old file-name-handler-alist))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq gc-cons-threshold (* 1024 1024 20))
              (setq file-name-handler-alist file-name-handler-alist-old)))
  (setq gc-cons-threshold most-positive-fixnum)
  (setq file-name-handler-alist nil))

;; Set font
(set-frame-font "Iosevka Term-12" nil t)
(add-to-list 'default-frame-alist '(font . "Iosevka Term-12"))

;; Package archives configuration
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
;; Now require and configure use-package
(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)
(setq auto-revert-interval 1            ; Refresh buffers fast
      create-lockfiles nil              ; Disable lockfiles
      default-input-method "TeX"        ; Use TeX when toggling input method
      echo-keystrokes 0.1               ; Show keystrokes asap
      enable-recursive-minibuffers t    ; Allow recursive minibuffers
      frame-inhibit-implied-resize 1    ; Don't resize frame implicitly
      inhibit-startup-screen t          ; No splash screen please
      initial-scratch-message nil       ; Clean scratch buffer
      recentf-max-saved-items 10000     ; Show more recent files
      ring-bell-function 'ignore        ; Quiet
      scroll-margin 1                   ; Space between cursor and top/bottom
      sentence-end-double-space nil     ; No double space
      custom-file (expand-file-name "custom.el" user-emacs-directory) ; Customizations file
      make-backup-files nil)            ; stop creating ~ files
(setq-default tab-width 4                       ; Smaller tabs
              fill-column 79                    ; Maximum line width
              truncate-lines t                  ; Don't fold lines
              indent-tabs-mode nil              ; Use spaces instead of tabs
              split-width-threshold 160         ; Split verticly by default
              split-height-threshold nil        ; Split verticly by default
              frame-resize-pixelwise t          ; Fine-grained frame resize
              auto-fill-function 'do-auto-fill) ; Auto-fill-mode everywhere
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-monokai-pro t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package company
  :ensure t
  :config
  (global-company-mode))
(add-hook 'after-init-hook 'global-company-mode)

(use-package web-mode
  :ensure t
  :mode
  (("\\.phtml\\'" . web-mode)
   ("\\.php\\'" . web-mode)
   ("\\.tpl\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)
   ("\\.html?\\'" . web-mode)))
