;;; Emacs system settings

(use-package emacs
  :straight nil
  :preface
  (defun reload-emacs-config ()
    "Reload config.el emacs configuration."
    (interactive)
    (load (expand-file-name "config.el" my-config-dir)))
  :config
  ;; System
  (setq warning-minimul-level :error)   ; only warn on errors
  (setq make-backup-files nil)          ; no temp files
  ;; Theme
  (add-to-list 'default-frame-alist     ; set font
	       '(font . "Blex Mono Nerd Font 18"))
  (setq inhibit-startup-message t)      ; no splash screen
  (menu-bar-mode -1)                    ; no menu bar
  (tool-bar-mode -1)                    ; no tool bar
  (scroll-bar-mode -1)                  ; no scroll bar
  (global-display-line-numbers-mode 1)) ; line numbers everywhere

;;; Straigh.el configurations

;; Install use-package
(straight-use-package 'use-package)

;; Make straight the default
(use-package straight
  :custom
  (straight-use-package-by-default t))

;;; Keybindings packages and settings

;;; Evil mode and related packages

;; Undo for evil mode
(use-package undo-fu)

;; Evil mode
(use-package evil
  :init
  (setq evil-want-keybinding nil)  ; needed for evil-collection
  (setq evil-want-C-u-scroll t)    ; allow scroll up with 'C-u'
  (setq evil-want-C-d-scroll t)    ; allow scroll down with 'C-d'
  (setq evil-undo-system 'undo-fu) ; undo system for 'C-r'
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

;; Theme
(use-package catppuccin-theme
  :init
  (setq catppuccin-flavor 'latte)
  (load-theme 'catppuccin :no-confirm))

;; Which key, in emacs 30 it will just be a "(require 'which-key)"
(use-package which-key
  :config
  (which-key-mode))

;; General for rebinding keys
(use-package general
  :config
  (general-evil-setup)
  (general-create-definer global/leader-keys
    :states '(normal insert viaul emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (global/leader-keys
    "r r" '(reload-emacs-config :wk "reload config")
    "b s" '(buffer-menu-other-window :wk "select buffer")
    "b k" '(kill-buffer-and-window :wk "kill buffer")
    "." '(find-file :wk "find file")
    ":" '(execute-extended-command :wk "execute command") 
    "!" '(shell-command :wk "shell command")
    "&" '(async-shell-command :wk "async shell command")))
