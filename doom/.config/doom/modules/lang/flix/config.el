;;; lang/flix/init.el -*- lexical-binding: t; -*-

(defconst flix-mode-keywords
  '("alias" "and" "as" "case" "catch" "chan" "choose" "class" "def"
    "default" "deref" "else" "enum" "exists" "false" "forall" "force"
    "from" "get" "if" "import" "inline" "instance" "into" "lat" "law"
    "lawless" "lazy" "let" "match" "matchEff" "mut" "namespace" "new"
    "not" "opaque" "or" "override" "project" "pub" "query" "ref"
    "reifyBool" "reifyEff" "reifyType" "rel" "scoped" "sealed" "select"
    "set" "solve" "spawn" "true" "try" "type" "unlawful" "use" "where"
    "with")
  "Keywords recognized by `flix-mode'.")

(defvar flix-mode-font-lock-keywords
  `(("\\_<Impure\\|null\\_>\\|\\?\\?\\?\\|\\?[_[:lower:]][_[:alnum:]]*" (0 font-lock-warning-face))
    ("\\_<Pure\\_>" (0 font-lock-function-name-face))
    ("\\_<\\(true\\|false\\)\\_>" (0 font-lock-builtin-face))
    ("def[ \t]+\\([_[:lower:]][_![:alnum:]]*\\)" (1 font-lock-function-name-face))
    ("let\\*?[ \t]+\\([_[:lower:]][_[:alnum:]]*\\)" (1 font-lock-variable-name-face))
    ("\\_<\\([_[:lower:]][_[:alnum:]]*\\)[ \t]*:[ \t_[:upper:]]" (1 font-lock-variable-name-face))
    ("\\_<\\([_[:upper:]][_[:alnum:]]*\\)\\_>" (0 font-lock-type-face))
    (,(concat "\\_<" (regexp-opt flix-mode-keywords) "\\_>") (0 font-lock-keyword-face)))
  "Keyword highlighting for `flix-mode'.")

(defvar flix-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\; "." st)
    (modify-syntax-entry ?: "." st)
    (modify-syntax-entry ?& "." st)
    (modify-syntax-entry ?# "." st)
    (modify-syntax-entry ?= "." st)
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\' "\"" st)
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for `flix-mode'.")

(defcustom flix-mode-tab-width 4
  "The tab width to use for indentation.")

(defun flix-mode--indent-further ()
  (interactive)
  (let ((new-indent (+ (current-indentation) flix-mode-tab-width)))
    (if (> (current-column) (current-indentation))
        (save-excursion (indent-line-to new-indent))
      (indent-line-to new-indent))))

(defun flix-mode--indent-less ()
  (interactive)
  (save-excursion
    (indent-line-to (max 0 (- (current-indentation) flix-mode-tab-width)))))

(defun flix-mode--newline-and-maybe-indent ()
  (interactive)
  (let ((indent-further (and (eolp) (looking-back "[{(=]")))
        (prev-indent (current-indentation)))
    (newline)
    (if indent-further
        (indent-line-to (+ prev-indent flix-mode-tab-width))
      (indent-line-to prev-indent))))

(defvar flix-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-m" 'flix-mode--newline-and-maybe-indent)
    (define-key map [return] 'flix-mode--newline-and-maybe-indent)
    (define-key map "\C-j" 'flix-mode--newline-and-maybe-indent)
    (define-key map [tab] 'flix-mode--indent-further)
    (define-key map [backtab] 'flix-mode--indent-less)
    map)
  "Keymap for `flix-mode'.")

;;;###autoload
(define-derived-mode flix-mode prog-mode "Flix"
  "A major mode for editing Flix files."
  :syntax-table flix-mode-syntax-table
  (setq-local indent-tabs-mode nil)
  (setq-local comment-start "//")
  (setq-local comment-start-skip "\\(//+\\|/\\*+\\) *")
  (setq-local comment-end "")
  (setq-local font-lock-defaults '(flix-mode-font-lock-keywords))
  (add-to-list 'electric-indent-chars ?\}))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.flix\\'" . flix-mode))

(provide 'flix-mode)

;;; flix-mode.el ends here
