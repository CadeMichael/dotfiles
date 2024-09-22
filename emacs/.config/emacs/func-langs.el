;;; function languages config --- functional language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Using taureg mode to support Ocaml editing in Emacs.
;;; Code:

;; Ocaml

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

;; Haskell
(use-package haskell-ts-mode)

;; Flix
(use-package flix-mode
  :straight
  (flix-mode :host github :type git :repo "cademichael/flix-mode")
  :bind
  (:map flix-mode-map
	("C-c C-r" . +flix/run-project)
	("C-c C-b" . +flix/build-project)
	("C-c C-d" . +flix/set-jar-directory)
	("C-c C-c C-i" . +flix/install-jar)
	("C-c C-i" . +flix/init-project)
	("C-c C-c C-r" . +flix/repl-restart)
	("C-c C-c C-t" . +flix/test-project)
	("C-c C-z" . +flix/goto-repl))
  (:map flix-repl-mode-map
	("C-c C-c C-r" . +flix/repl-restart)
	("C-c C-z" . +flix/goto-flix-buffer)))

;;; func-langs.el ends here
