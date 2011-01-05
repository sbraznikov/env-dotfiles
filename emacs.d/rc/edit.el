(custom-set-variables
 '(imenu-auto-rescan t)
 '(diff-default-read-only t)
 '(auto-save-list-file-name nil)
 '(auto-save-default nil)
 '(backup-by-copying-when-mismatch t)
 '(grep-find-ignored-directories '("CVS" ".svn" ".hg" "{arch}"))
 '(current-language-environment "UTF-8")
 '(backward-delete-function nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(truncate-lines t)
 '(require-final-newline t)
 '(sandart-indent 4)
 '(save-place t nil (saveplace))
 '(truncate-lines t)
 '(size-indication-mode t)
 '(comment-style 'indent)
 '(save-abbrevs nil)
 '(default-major-mode 'text-mode)
 '(default-fill-column 79)
 '(make-backup-files nil)
 '(x-select-enable-clipboard t)
 '(mac-option-modifier nil)
 '(indent-tabs-mode nil)
 '(words-include-escapes t)
 '(tab-width 4)
 '(speedbar-show-unknown-files t)
 '(speedbar-sort-tags t)
 '(speedbar-use-images nil)
 '(flymake-allowed-file-name-masks (quote nil))
 '(x-select-enable-clipboard nil)
 )

(defun my-copy-line ()
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position))
  (end-of-line)
  (newline)
  (cua-paste nil))

(defun my-indent-clean-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (tabify (point-min) (point-max)))

(defun my-indent-whole-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (mark-whole-buffer)
  (indent-region (point-min) (point-max) nil))

(defun my-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "\\s\(")
		 (forward-list 1) (backward-char 1))
		((looking-at "\\s\)")
		 (forward-char 1) (backward-list 1))
		(t (self-insert-command (or arg1)))))

(defadvice cua-paste (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode
                           lisp-mode
                           c-mode c++-mode latex-mode
                           html-mode python-mode css-mode php-mode javascript-mode))
      (indent-region (region-beginning) (region-end) nil)))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode
                           scheme-mode lisp-mode
                           c-mode c++-mode objc-mode
                           latex-mode plain-tex-mode
                           php-mode nxml-mode
                           ruby-mode))
      (indent-region (region-beginning) (region-end) nil)))

(defalias 'ir 'indent-region)
(defalias 'irf 'my-indent-whole-buffer)
(defalias 'ur 'upcase-region)
(defalias 'dr 'downcase-region)

(defun my-search-word-under-cursor (arg)
  (interactive "p")
  (save-excursion
    (setq string (current-word))
    (occur string)))

(defun my-duplicate-current-line-or-region (arg)
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
