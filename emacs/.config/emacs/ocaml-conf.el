;;; ocaml-config --- Ocaml language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Using taureg mode to support Ocaml editing in Emacs.
;;; Code:

;; Tuareg mode for completion and code editing
(use-package tuareg)

;; Utop for repl based workflows
(use-package utop
  :config
  (setq utop-command "opam exec -- utop -emacs") ; prevent path issues
  :hook
  (tuareg-mode . utop-minor-mode))

;; +-----------+-------------------+-----------+
;; |key-binding|function           |Description|
;; +-----------+-------------------+-----------+
;; |C-c C-s    |utop               |Start a    |
;; |           |                   |utop buffer|
;; +-----------+-------------------+-----------+
;; |C-x C-e    |utop-eval-phrase   |Evaluate   |
;; |           |                   |the current|
;; |           |                   |phrase     |
;; +-----------+-------------------+-----------+
;; |C-x C-r    |utop-eval-region   |Evaluate   |
;; |           |                   |the        |
;; |           |                   |selected   |
;; |           |                   |region     |
;; +-----------+-------------------+-----------+
;; |C-c C-b    |utop-eval-buffer   |Evaluate   |
;; |           |                   |the current|
;; |           |                   |buffer     |
;; +-----------+-------------------+-----------+
;; |C-c C-k    |utop-kill          |Kill a     |
;; |           |                   |running    |
;; |           |                   |utop       |
;; |           |                   |process    |
;; +-----------+-------------------+-----------+
;; |C-c C-z    |utop-switch-to-repl|Switch to  |
;; |           |                   |utop       |
;; |           |                   |process    |
;; +-----------+-------------------+-----------+

;;; ocaml-conf.el ends here
