;;; rust-config --- Rust language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; using rust mode and flycheck for rust to prevent errors
;;; Code:

(use-package rust-mode
  :init
  (setq rust-mode-form t)
  (setq rust-mode-treesitter-derive t))

(use-package flycheck-rust
  :after rust-mode
  :hook
  (flycheck-mode . flycheck-rust-setup))

;;; rust-conf.el ends here
