;;; init.el --- Main initialization file -*- lexical-binding: t -*-

;;; Commentary:
;; Main Emacs configuration file

;;; Code:

;; =============================================================================
;; Package Management
;; =============================================================================

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Refresh package contents if needed
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; =============================================================================
;; Font Configuration
;; =============================================================================

(when (find-font (font-spec :name "Iosevka Term"))
  (set-frame-font "Iosevka Term-14" nil t)
  (add-to-list 'default-frame-alist '(font . "Iosevka Term-12")))

;; =============================================================================
;; General Settings
;; =============================================================================

(setq auto-revert-interval 1
      create-lockfiles nil
      default-input-method "TeX"
      echo-keystrokes 0.1
      enable-recursive-minibuffers t
      inhibit-startup-screen t
      initial-scratch-message nil
      recentf-max-saved-items 10000
      ring-bell-function 'ignore
      scroll-margin 1
      sentence-end-double-space nil
      custom-file (expand-file-name "custom.el" user-emacs-directory)
      make-backup-files nil)

(setq-default tab-width 4
              fill-column 79
              truncate-lines t
              indent-tabs-mode nil
              split-width-threshold 160
              split-height-threshold nil
              auto-fill-function 'do-auto-fill)

;; =============================================================================
;; Theme Configuration
;; =============================================================================

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-atom")
  :config
  (load-theme 'doom-monokai-pro t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; =============================================================================
;; Completion Framework
;; =============================================================================

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))

;; =============================================================================
;; Evil Mode
;; =============================================================================

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil)
  :config
  (evil-mode 1)
  
  ;; Window navigation in normal mode
  (evil-define-key 'normal 'global
    (kbd "C-h") #'evil-window-left
    (kbd "C-j") #'evil-window-down
    (kbd "C-k") #'evil-window-up
    (kbd "C-l") #'evil-window-right))

;; =============================================================================
;; Multiple Cursors
;; =============================================================================

(use-package multiple-cursors
  :ensure t
  :bind (("C-M-j" . mc/mark-all-dwim)
         ("C-M-c" . mc/edit-lines)
         ("C-M-/" . mc/mark-all-like-this)
         ("C-M-," . mc/mark-previous-like-this)
         ("C-M-." . mc/mark-next-like-this)
         ("C-M-<" . mc/skip-to-previous-like-this)
         ("C-M->" . mc/skip-to-next-like-this)))

(use-package expand-region
  :ensure t
  :bind ("C-M-l" . er/expand-region))

;; =============================================================================
;; Web Development
;; =============================================================================

(use-package web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.php\\'" . web-mode)
         ("\\.tpl\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.jsx?\\'" . web-mode)
         ("\\.tsx?\\'" . web-mode)
         ("\\.vue\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t))

(use-package emmet-mode
  :ensure t
  :hook ((web-mode . emmet-mode)
         (html-mode . emmet-mode)
         (css-mode . emmet-mode)
         (scss-mode . emmet-mode)
         (sgml-mode . emmet-mode))
  :config
  (setq emmet-move-cursor-between-quotes t
        emmet-expand-jsx-className? t))

(use-package auto-rename-tag
  :ensure t
  :hook ((web-mode . auto-rename-tag-mode)
         (html-mode . auto-rename-tag-mode)))

;; =============================================================================
;; CSS/SCSS
;; =============================================================================

(use-package css-mode
  :ensure nil
  :mode "\\.css\\'"
  :config
  (setq css-indent-offset 2))

(use-package scss-mode
  :ensure t
  :mode "\\.scss\\'"
  :config
  (setq scss-compile-at-save nil))

;; =============================================================================
;; JavaScript
;; =============================================================================

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :config
  (setq js2-basic-offset 2
        js2-bounce-indent-p t))

;; =============================================================================
;; Data Formats
;; =============================================================================

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

;; =============================================================================
;; Markdown
;; =============================================================================

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (setq markdown-command "pandoc"))

(use-package markdown-preview-mode
  :ensure t
  :after markdown-mode
  :commands markdown-preview-mode)

;; =============================================================================
;; Code Formatting
;; =============================================================================

(use-package prettier-js
  :ensure t
  :hook ((web-mode . prettier-js-mode)
         (js2-mode . prettier-js-mode)
         (css-mode . prettier-js-mode)
         (json-mode . prettier-js-mode)))

(use-package web-beautify
  :ensure t
  :bind (:map web-mode-map
              ("C-c b" . web-beautify-html)
         :map js2-mode-map
              ("C-c b" . web-beautify-js)
         :map css-mode-map
              ("C-c b" . web-beautify-css)))

;; =============================================================================
;; Syntax Checking
;; =============================================================================

(use-package flycheck
  :ensure t
  :hook ((web-mode . flycheck-mode)
         (js2-mode . flycheck-mode)
         (css-mode . flycheck-mode))
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; =============================================================================
;; Additional Completion
;; =============================================================================

(use-package company-web
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-web-html)
  (add-to-list 'company-backends 'company-web-jade)
  (add-to-list 'company-backends 'company-web-slim))

;; =============================================================================
;; Visual Aids
;; =============================================================================

(use-package indent-guide
  :ensure t
  :hook ((web-mode . indent-guide-mode)
         (js2-mode . indent-guide-mode)
         (css-mode . indent-guide-mode)))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; =============================================================================
;; Terminal Emulator
;; =============================================================================

(use-package vterm
  :ensure t
  :commands vterm)

(use-package platformio-mode
  :ensure t)
;; =============================================================================
;; Key Bindings
;; =============================================================================

(global-set-key (kbd "C-x C-b") #'ibuffer)

;; =============================================================================
;; Load Custom File
;; =============================================================================

(when (file-exists-p custom-file)
  (load custom-file))

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) . 
         (lambda () (require 'ccls) (lsp)))
  :config
  (setq ccls-executable "/usr/bin/ccls"))

;; Suppress native compilation warnings
(setq native-comp-async-report-warnings-errors nil)
(setq byte-compile-warnings '(not docstrings))
(setq warning-minimum-level :error)
