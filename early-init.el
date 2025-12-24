;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:
;; Emacs 27+ early initialization file
;; This runs before package.el and GUI initialization

;;; Code:

;; Performance optimizations during startup
(setq gc-cons-threshold most-positive-fixnum
      file-name-handler-alist nil)

;; Restore after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 1024 1024 20)
                  file-name-handler-alist (default-value 'file-name-handler-alist))))

;; Package system configuration (before package.el loads)
(setq package-enable-at-startup nil
      package-quickstart nil)

;; UI optimizations (disable before GUI frame creation)
(setq frame-inhibit-implied-resize t)
(setq-default frame-resize-pixelwise t)

;; Disable unnecessary UI elements early
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;;; early-init.el ends here
