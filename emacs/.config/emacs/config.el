;;; main-config --- Cade's Emacs Config -*- lexical-binding: t; -*-
;;; Commentary:
;; Should work with macos and linux.
;; Configured for
;; -> Rust
;; -> Python
;; -> Ocaml
;; -> Markdown
;; -> Flix
;;; Code:

;; Emacs system settings
(use-package emacs
  :straight nil
  :defer t
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
  (setopt use-short-answers t)		; y or n
  (setq auto-save-default nil) 		; don't auto save

  ;; Theme
  (if (eq system-type 'darwin)          ; set font based on OS
      (add-to-list 'default-frame-alist
		   '(font . "Monoid Nerd Font 16"))
    (add-to-list 'default-frame-alist
		 '(font . "JetBrainsMono Nerd Font 12")))
  (setq inhibit-startup-message t)      ; no splash screen
  (menu-bar-mode -1)                    ; no menu bar
  (tool-bar-mode -1)                    ; no tool bar
  (scroll-bar-mode -1)                  ; no scroll bar
  (global-visual-line-mode)		; better line wrapping

  ;; Org mode / notes
  (require 'org-tempo)                  ; org snippets
  (setq org-startup-indented t)         ; indent org mode
  (setq                                 ; no indent in src blocks
   org-edit-src-content-indentation 0)
  (setq org-src-preserve-indentation t) ; fix src block indents
  (setq org-src-tab-acts-natively t)    ; allow indenting in src blocks
  (setq org-format-latex-options        ; preview size for latex
	(plist-put org-format-latex-options :scale 2.5))
  (org-babel-do-load-languages          ; load babel languages
   'org-babel-load-languages
   '((python . t)))

  :hook
  ;; Programming mode hooks
  (prog-mode . display-line-numbers-mode)
  (prog-mode . hl-line-mode)
  ;; Folding for non ts-modes
  (emacs-lisp-mode . hs-minor-mode)
  (c++-mode . hs-minor-mode))

;; Straigh.el configurations

;; Package management and setup with use-package
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
(use-package catppuccin-theme
  :custom
  (catppuccin-flavor 'mocha)
  :init
  (load-theme 'catppuccin :no-confirm))

;; Modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon nil)
  (setq doom-modeline-height 25))

;; Icons in dired
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Different colors for different delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Completion engines

;; Orderless to get better completions
(use-package orderless
  :custom
  (completion-styles
   '(basic partial-completion orderless))) ; orderless needs to be last

;; Vertico for completion UI
(use-package vertico
  :init
  (vertico-mode))

;; Company mode for text completion popup
(use-package company
  :config
  (global-company-mode t))

;; Consult for searching, grepping, and project exploration
(use-package consult)

;; Get detailed popup descriptions
(use-package marginalia
  :init
  (marginalia-mode))

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
  ;; global keybindings
  (general-create-definer global/leader-keys
    :defer t
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (global/leader-keys
    ;; SPC +
    "r r" '(reload-emacs-config :wk "reload config")
    "b s" '(consult-buffer :wk "consult buffer")
    "b k" '(kill-buffer-and-window :wk "kill buffer and window")
    "o c" '(open-config-file :wk "open config file")
    ;; lazygit
    "l g" '(+eat/lazy-git :wk "lazygit")
    ;; use "--" to pass options to `ripgrep'
    "f r" '(consult-ripgrep :wk "consult ripgrep")
    "f f" '(consult-find :wk "consult find")
    "p s" '(project-switch-project :wk "project switch")
    "p k" '(project-kill-buffers :wk "project kill buffers")
    "p F" '(project-forget-project :wk "project forget")
    "p R" '(project-remember-projects-under :wk "project remember projects under")
    "p !" '(project-shell-command :wk "project shell command")
    "p &" '(project-async-shell-command :wk "project async shell command")
    "c c" '(quickrun :wk "quickrun")
    "SPC" '(+eat/other-window-or-last-buffer :wk "eat other window or last buffer")
    "E" '(consult-flymake :wk "consult flymake")
    "q" '(kill-emacs :wk "kill emacs")
    "m" '(consult-imenu :wk "consult imenu")
    "g" '(magit :wk "magit")
    "/" '(consult-line :wk "consult find line")
    "." '(find-file :wk "find file")
    ":" '(execute-extended-command :wk "execute extended command") ; M-x
    "!" '(shell-command :wk "shell command")
    "&" '(async-shell-command :wk "async shell command")))

;; Version control management
(use-package magit)

;; Show where changes are in a vc tracked file
(use-package git-gutter
  :init
  (global-git-gutter-mode +1)
  :config
  (general-nmap 'override
    "[g" 'git-gutter:previous-hunk
    "]g" 'git-gutter:next-hunk))

;; Programming tooling for IDE like features

;; Better terminal emulation
(use-package eat
  :defer t
  :straight (eat :type git
		 :host codeberg
		 :repo "akib/emacs-eat"
		 :files ("*.el" ("term" "term/*.el") "*.texi"
			 "*.ti" ("terminfo/e" "terminfo/e/*")
			 ("terminfo/65" "terminfo/65/*")
			 ("integration" "integration/*")
			 (:exclude ".dir-locals.el" "*-tests.el")))
  :config
  ;; evil keybindings
  (general-nmap 'eat-mode-map
    "q" 'quit-window)
  ;; configuring terminal
  (setq eat-term-name "eat-color")
  (setq eat-kill-buffer-on-exit t)
  (defvar +eat/last-buffer nil))

;;;###autoload
(defun +eat/other-window-or-last-buffer ()
  "Either open `eat' in a new window or switch to last buffer to call eat."
  (interactive)
  (let ((mode major-mode))
    (if (eq mode 'eat-mode)
	(when (bound-and-true-p +eat/last-buffer)
	  (switch-to-buffer-other-window +eat/last-buffer))
      (let ((buffer (current-buffer)))
	(setq +eat/last-buffer buffer)
	(eat-other-window)))))

;;;###autoload
(defun +eat/lazy-git ()
  "Open Lazygit in a new Eat window."
  (interactive)
  (eat-other-window "lazygit" "P")
  (delete-other-windows))

;; Elisp overlays
(use-package eros
  :init
  (eros-mode 1))

;; Project configurations
(use-package project
  :straight nil
  :preface
  ;; find cmake projects
  (defun project-find-cmake (dir)
    (when-let ((root (locate-dominating-file dir "CMakeLists.txt")))
      (cons 'cmake-lists root)))
  (cl-defmethod project-root ((project (head cmake-lists)))
    (cdr project))
  :config
  (add-hook 'project-find-functions 'project-find-cmake))

;; Eglot with limited mini buffer madness
(use-package eglot
  :straight nil
  :custom
  (eldoc-echo-area-use-multiline-p nil))

;; Debugging
(use-package realgud
  :defer t
  :config
  (setq realgud-window-split-orientation 'horizontal))
;; lldb support
(use-package realgud-lldb
  :after realgud)

;; Running code more dynamically
(use-package quickrun)

;; Treesitter for syntax
(use-package treesit
  :straight nil
  :config
  (setq treesit-font-lock-level 4) ; maximum highlighting
  (setq major-mode-remap-alist
	'((python-mode . python-ts-mode)
	  (c-mode . c-ts-mode)
	  (java-mode . java-ts-mode))))

;; Folding for `treesit' supported languages
(use-package treesit-fold
  :straight
  (treesit-fold :type git :host github :repo "emacs-tree-sitter/treesit-fold")
  :init
  (global-treesit-fold-mode))

;; For shell scripting
(use-package sh-script
  :straight nil)

;; Load rust config
(load-config-file "rust-conf.el")

;; Load python config
(load-config-file "python-conf.el")

;; Load ocaml config
(load-config-file "ocaml-conf.el")

;; Load markdown config
(load-config-file "md-conf.el")

;; Load flix config
(load-config-file "flix-conf.el")

;; Load verification config
(load-config-file "verif-conf.el")

;;; config.el ends here
