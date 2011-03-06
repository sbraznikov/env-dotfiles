(ido-mode t)

(setq ido-enable-prefix nil
      ido-everywhere t
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10)

(setq ido-ignore-buffers (quote ("^ " "*Messages*" "*Buffer" "*Completions" "*Ibuffer" "*.svn-base")))
(setq ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`svn/")))
(setq ido-ignore-files (quote ("\\`CVS/" "\\`#" "\\`.#" "\\`SVN/" "\\`.pyc/" "\\`.svn-base/")))
(setq ido-confirm-unique-completion t)
;; (setq ido-enable-prefix t)

(defun ido-find-file-in-tag-files()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (ido-completing-read "Project Files: "
						  (tags-table-files)
						  nil t))))

(defun ido-read-tag (prompt &optional require-match initial-input)
  (let ((enable-recursive-minibuffers t))
    (visit-tags-table-buffer)
    (ido-completing-read prompt
						 (let ((accum (list)))
						   (mapatoms (lambda (arg) (push (symbol-name arg) accum))
									 (tags-completion-table))
						   accum)
						 nil require-match initial-input)))

(defun ido-find-tag ()
  (interactive)
  (let ((default (symbol-at-point)))
	(find-tag (ido-read-tag (format "Find tag: " default) nil
							(and default (symbol-name default))))))

(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
