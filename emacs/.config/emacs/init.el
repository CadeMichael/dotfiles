;;; init.el --- setup packages -*- lexical-binding: t; -*-
;;; Commentary:
;; Bootstrap straight.el so that it can setup pacakge management.
;; Create the variable for config directory
;;; Code:

;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; Load user config

;; Get the directory of the current file (`init.el`)
(defvar my-config-dir (file-name-directory load-file-name))

;; Load `config.el` relative to `init.el`
(load (expand-file-name "config.el" my-config-dir))

;;; init.el ends here
