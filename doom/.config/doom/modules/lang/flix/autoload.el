;;; lang/flix/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +flix/install-jar ()
  "Install flix.jar in a selected directory if it is not already present."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (selected-dir (read-directory-name "Install into directory: " default-directory))
         (jar-path (concat (file-name-as-directory selected-dir) "flix.jar"))
         (download-url "https://github.com/flix/flix/releases/latest/download/flix.jar"))
    (if (file-exists-p jar-path)
        (message "flix.jar is already installed.")
      (url-copy-file download-url jar-path t)
      (message "flix.jar has been downloaded and installed."))))

;;;###autoload
(defun +flix/flix-command ()
  "initialize a flix project in the selected directory if flix.jar is present."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (selected-dir (read-directory-name "init project in: " default-directory))
         (command (read-string "Command: "))
         (jar-path (concat (file-name-as-directory selected-dir) "flix.jar")))
    (if (file-exists-p jar-path)
        (let ((default-directory selected-dir))
          (message (concat "Running flix " command "..."))
          (async-shell-command (concat "java -jar flix.jar " command)))
      (message "flix.jar not found in the selected directory."))))

;;;###autoload
(defun +flix/init-project ()
  "initialize a flix project in the selected directory if flix.jar is present."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (selected-dir (read-directory-name "init project in: " default-directory))
         (jar-path (concat (file-name-as-directory selected-dir) "flix.jar")))
    (if (file-exists-p jar-path)
        (let ((default-directory selected-dir))
          (message "initializing flix project...")
          (shell-command "java -jar flix.jar init"))
      (message "flix.jar not found in the selected directory."))))

;;;###autoload
(defun +flix/run-project ()
  "Initialize a Flix project in the selected directory if flix.jar is present."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (selected-dir (read-directory-name "Flix exe: " default-directory))
         (jar-path (concat (file-name-as-directory selected-dir) "flix.jar")))
    (if (file-exists-p jar-path)
        (let ((default-directory selected-dir))
          (message "Running Flix project...")
          (async-shell-command "java -jar flix.jar run"))
      (message "flix.jar not found in the selected directory."))))

;;;###autoload
(defun +flix/build-project ()
  "Initialize a Flix project in the selected directory if flix.jar is present."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (selected-dir (read-directory-name "Flix exe: " default-directory))
         (jar-path (concat (file-name-as-directory selected-dir) "flix.jar")))
    (if (file-exists-p jar-path)
        (let ((default-directory selected-dir))
          (message "Building Flix project...")
          (async-shell-command "java -jar flix.jar build"))
      (message "flix.jar not found in the selected directory."))))
