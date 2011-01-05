;;(require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.phtml$" . php-mode))

(defun my-php-mode-settings ()
  (c-subword-mode)
  (c-set-offset 'comment-intro '0)
  (c-set-offset 'arglist-close '0)
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'statement-cont '4)
  (set (make-local-variable 'funclist-lang-exp)
	   "^\\s-*\\(public\\|private\\|protected\\)\\s-+function\\s-+\\([a-zA-Z0-9_]+\\)\\s-*(")
   ;; (define-key php-mode-map (kbd "TAB") 'self-insert-command)
   )

(add-hook 'php-mode-hook 'my-php-mode-settings)

;; flymake configuration
(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
         (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
             '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))


(defvar my-php-search-url "http://www.php.net/")
(defvar my-php-manual-url "http://www.php.net/manual/en/")

(defun my-php-search-documentation ()
  "Search PHP documentation for the word at the point."
  (interactive)
  (browse-url (concat my-php-search-url (current-word t))))

(defun my-php-browse-manual ()
  "Bring up manual for PHP."
  (interactive)
  (browse-url my-php-manual-url))
