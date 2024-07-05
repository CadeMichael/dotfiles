;;; main-config --- Cade's Emacs Config -*- lexical-binding: t; -*-
;;; Commentary:
;; Should work with macos and linux.
;; Configured for
;; -> Rust
;; -> Python
;; -> Ocaml
;;; Code:

;; Emacs system settings
(use-package emacs
  :straight nil
  :preface
  (defun load-config-file (file)
    "Load files in the config dir."
    (load (expand-file-name file my-config-dir)))
  (defun reload-emacs-config ()
    "Reload config.el emacs configuration."
    (interactive)
    (load (expand-file-name "config.el" my-config-dir)))
  (defun open-config-file ()
    "Open this file ie 'config.el'."
    (interactive)
    (find-file (expand-file-name "config.el" my-config-dir)))
  :config
  ;; System
  (setq warning-minimul-level :error)   ; only warn on errors
  (setq                                 ; no warnings
   native-comp-async-report-warnings-errors nil)
  (setq ring-bell-function 'ignore)     ; no bell noise
  (setq make-backup-files nil)          ; no temp files
  (setq read-extended-command-predicate ; only show 'M-x' commands relevant to mode
	#'command-completion-default-include-p)
  (setq enable-recursive-minibuffers t) ; allow opening minibufs in minibufs

  ;; Theme
  (if (eq system-type 'darwin)          ; set font based on OS
      (add-to-list 'default-frame-alist
		   '(font . "Hack Nerd Font 16"))
    (add-to-list 'default-frame-alist
		 '(font . "Blex Mono Nerd Font 18")))
  (setq inhibit-startup-message t)      ; no splash screen
  (menu-bar-mode -1)                    ; no menu bar
  (tool-bar-mode -1)                    ; no tool bar
  (scroll-bar-mode -1)                  ; no scroll bar

  ;; Org mode / notes
  (require 'org-tempo)                  ; org snippets
  (setq org-startup-indented t)         ; indent org mode
  (setq                                 ; no indent in src blocks
   org-edit-src-content-indentation 0)
  (setq org-src-preserve-indentation t) ; fix src block indents
  (setq org-src-tab-acts-natively t)    ; allow indenting in src blocks
  (org-babel-do-load-languages          ; load babel languages
   'org-babel-load-languages
   '((python . t)))

  :hook
  ;; Programming mode hooks
  (prog-mode . display-line-numbers-mode))

;; Straigh.el configurations

;; Install use-package
(straight-use-package 'use-package)

;; Make straight the default
(use-package straight
  :custom
  (straight-use-package-by-default t)
  (straight-cache-autoloads t))

;; Evil mode and related packages

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

;; Path management to keep env variable consistent
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; Evil collections for keybindings accross modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Themeing

;; Theme
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox :no-confirm))

;; Modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25))


;; Completion engines

;; Install vertico for completion UI
(use-package vertico
  :init
  (vertico-mode))

;; Company mode for text completion popup
(use-package company
  :config
  (global-company-mode t))

;; Consult for project searching
(use-package consult)

;; Keybindings packages and settings

;; Which key, in emacs 30 it will just be a "(require 'which-key)"
(use-package which-key
  :config
  (which-key-mode))

;; General for rebinding keys
(use-package general
  :after magit
  :config
  (general-evil-setup)
  (general-create-definer global/leader-keys
    :states '(normal insert viaul emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (global/leader-keys
    "r r" '(reload-emacs-config :wk "reload config")
    "b s" '(consult-buffer :wk "switch to buffer")
    "b k" '(kill-buffer-and-window :wk "kill buffer")
    "o c" '(open-config-file :wk "open config file")
    "p s" '(consult-ripgrep :wk "search project for text")
    "p f" '(consult-find :wk "search project for file")
    "p x" '(project-find-regexp :wk "project find regexp")
    "g" '(magit :wk "magit")
    "." '(find-file :wk "find file")
    ":" '(execute-extended-command :wk "execute command")
    "!" '(shell-command :wk "shell command")
    "&" '(async-shell-command :wk "async shell command")))

;; Version control management
(use-package magit)

;; Language specific configs

;; Flyspell for linting
(use-package flycheck
  :init
  (global-flycheck-mode))

;; Treesitter for syntax
(use-package treesit
  :straight nil
  :config
  (setq treesit-font-lock-level 4) ; maximum highlighting
  (setq major-mode-remap-alist
	'((python-mode . python-ts-mode))))

;; Load rust config
(load-config-file "rust-conf.el")

;; Load python config
(load-config-file "python-conf.el")

;; Load ocaml config
(load-config-file "ocaml-conf.el")

;; Load markdown config
(load-config-file "md-conf.el")

;;; config.el ends here
