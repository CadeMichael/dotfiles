;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(setq doom-font
      (if doom--system-macos-p
          (font-spec :family "Hack Nerd Font Mono" :size 18)
        (font-spec :family "Blex Mono Nerd Font" :size 14)))

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(when doom--system-macos-p (add-hook 'window-setup-hook #'toggle-frame-maximized))

(after! neotree
  (setq neo-window-position 'right))

(setq-hook! vterm-mode evil-insert-state-cursor '(box "#FFFFFF"))

(dolist (hook '(prog-mode-hook
                text-mode-hook
                coq-mode-hook
                global-prettify-symbols-mode-hook
                doom-init-ui-hook
                doom-first-input-hook
                doom-first-file-hook))
  (remove-hook hook #'prettify-symbols-mode))
