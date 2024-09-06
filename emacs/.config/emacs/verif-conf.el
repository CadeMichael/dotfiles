;;; verif-config --- Configuration for Coq and verification languages.
;;; Commentary:
;; using proof general for these langauges
;; https://proofgeneral.github.io/doc/master/userman/Coq-Proof-General/#Coq-Proof-General
;;; Code:

(use-package proof-general
  :defer t
  :after coq-mode
  :bind
  (:map coq-mode-map
	("C-c ." . proof-retract-until-point-interactive)))

;;; verif-conf.el ends here
