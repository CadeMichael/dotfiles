;;; rust-config --- Rust language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; using rust mode and flycheck for rust to prevent errors
;;; Code:

(use-package rust-mode
  :init
  (setq rust-mode-form t)
  (setq rust-mode-treesitter-derive t)
  :config
  (quickrun-add-command "rust"
    '((:command . "cargo")
      (:exec    . ("%c run"))
      (:tempfile . nil))
    :default "rust"))

;;; rust-conf.el ends here
