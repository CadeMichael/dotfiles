;;; Emacs system settings

;; Native comp setting
(setq warning-minimum-level :error)

;; No backup files
(setq make-backup-files nil)

;;; Straigh.el configurations

;; Install use-package
(straight-use-package 'use-package)

;; Make straight the default
(use-package straight
  :custom
  (straight-use-package-by-default t))

;;; Evil mode and related packages

;; Undo for evil mode
(use-package undo-fu)

;; Evil mode
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;;; Path management to keep env variable consistent
(use-package exec-path-from-shell)

;; Evil collections for keybindings accross modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;;; Themeing

;; Font specification
(add-to-list 'default-frame-alist
             '(font . "Blex Mono Nerd Font 18"))

;; Theme
(use-package catppuccin-theme
  :init
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm))

;; No spash screen
(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;;; Keybindings packages and settings

;; Which key, in emacs 30 it will just be a "(require 'which-key)"
(use-package which-key
  :config
  (which-key-mode))
