;;; rust-config --- Rust language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; using rust mode and flycheck for rust to prevent errors
;;; Code:

(use-package rust-mode
  :defer t
  :config
  (setq rust-mode-form t)
  (setq rust-mode-treesitter-derive t))

;;; rust-conf.el ends here
