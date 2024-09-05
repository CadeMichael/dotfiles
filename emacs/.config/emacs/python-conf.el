;;; python-config --- Python language packages and configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Writing some custom functions to better interact with python
;;; Code:

(defvar python-last-buffer nil
  "The last python buffer to call the repl.")

(defun +python/goto-python-buffer ()
  "Switch to active python REPL."
  (interactive)
  (if (buffer-live-p (get-buffer python-last-buffer))
      (switch-to-buffer-other-window python-last-buffer)
    (message "python buffer deleted")))

(defun +python/goto-repl ()
  "Switch to active python REPL."
  (interactive)
  (setq python-last-buffer (current-buffer))
  (python-shell-switch-to-shell))

(defun +python/run-python ()
  "Start python process."
  (interactive)
  (setq python-last-buffer (current-buffer))
  (run-python))

(use-package python
  :straight nil
  :defer t
  :config
  (quickrun-add-command "python"	; quicky run python files
    '((:command . "python3")
      (:exec    . ("%c %s"))
      (:tempfile . nil))
    :default "python")
  :bind
  (:map python-ts-mode-map
   ([remap python-shell-switch-to-shell] . +python/goto-repl)
   ([remap run-python] . +python/run-python)
   :map inferior-python-mode-map
   ("C-c C-z" . +python/goto-python-buffer)))

(use-package pyvenv
  :config
  (setq python-shell-interpreter "python"))

;;; python-conf.el ends here
