;;; flix-config --- Flix language configurations-*- lexical-binding: t; -*-
;;; Commentary:
;; Using custom flix-mode package
;;; Code:

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

;;; flix-conf.el ends here
