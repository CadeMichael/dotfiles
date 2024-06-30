;;;###autoload
(defun +flix/install-jar ()
  "Install flix.jar in the project root if it is not already present."
  (interactive)
  (when-let ((root (project-root (project-current t))))
    (let ((jar-path (concat root "flix.jar"))
          (download-url "https://github.com/flix/flix/releases/latest/download/flix.jar"))
      (if (file-exists-p jar-path)
          (message "flix.jar is already installed.")
        (url-copy-file download-url jar-path t)
        (message "flix.jar has been downloaded and installed.")))))
