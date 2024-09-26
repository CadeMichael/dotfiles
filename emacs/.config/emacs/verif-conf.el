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
	("C-c ." . proof-retract-until-point-interactive)))

;; Idris2
(use-package idris-mode
  :custom
  (idris-interpreter-path "idris2"))

;; Agda (installed when installing Agda via cabal)
(when (not (eq system-type 'darwin))
  (load-file (let ((coding-system-for-read 'utf-8))
	       (shell-command-to-string "agda-mode locate"))))

;;; verif-conf.el ends here
