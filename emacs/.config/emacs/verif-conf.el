;;; verif-config --- Configuration for Coq and verification languages.
;;; Commentary:
;; using proof general for these langauges
;; https://proofgeneral.github.io/doc/master/userman/Coq-Proof-General/#Coq-Proof-General
;;; Code:

;; Coq + Isabelle
(use-package proof-general
  :defer t
  :after coq-mode
  :bind
  (:map coq-mode-map
	("C-c RET" . proof-assert-next-command-interactive)
	("C-c DEL" . proof-retract-until-point-interactive)))

;; Coq IDE
(use-package company-coq
  :hook
  (coq-mode . company-coq-mode))

;; Lean4
(use-package lean4-mode
  :straight (lean4-mode
	     :type git
	     :host github
	     :repo "leanprover/lean4-mode"
	     :files ("*.el" "data"))
  ;; to defer loading the package until required
  :commands (lean4-mode))

;; Idris2
(use-package idris-mode
  :custom
  (idris-interpreter-path "idris2"))

;; Agda (installed when installing Agda via cabal)
(when (not (eq system-type 'darwin))
  (load-file (let ((coding-system-for-read 'utf-8))
	       (shell-command-to-string "agda-mode locate"))))

;;; verif-conf.el ends here
