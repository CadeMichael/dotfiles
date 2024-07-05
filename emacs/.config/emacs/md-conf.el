;;; markdown-config --- Makrdown language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Using markdown mode for editing markdown files.
;;; Code:

;; Markdown mode for highlighting
(use-package markdown-mode
  :init
  (setq markdown-command "multimarkdown"))

;;; md-conf.el ends here
