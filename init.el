(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq load-path (cons "~/.emacs.d" load-path))

;; ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

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

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
;; ido end


;; c
(setq c-default-style "bsd")
(setq c-doc-comment-style "javadoc")
(setq c-basic-offset 4)
(setq c-indent-tabs-mode t)
(setq c-tab-always-indent t)
(setq c-indent-level 4)
(setq c-continued-statement-offset 4)
(setq c-brace-offset -4)
(setq c-argdecl-indent 0)

(setq c-label-offset -4)
(setq c-auto-hungry-initial-state 'none)
(setq c-delete-function 'backward-delete-char)
(setq c-toggle-auto-state 1)
;; c end


;; edit
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

(defun my-indent-whole-buffer ()
  (interactive)
  (delete-trailing-whitespace)
  (mark-whole-buffer)
  (indent-region (point-min) (point-max) nil))

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
;; edit end


;; frame
(custom-set-variables
 '(inhibit-startup-message t)
 '(default-frame-alist nil)
 '(menu-bar-mode nil)
 '(mouse-wheel-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(1 ((shift) . 1)))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-follow-mosue 't)
 '(scroll-step 1)
 '(messages-buffer-max-lines 2500)
 '(bell-volume 0)
 '(visible-bell 0)
 '(sound-alist nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 50)
 '(scroll-preserve-screen-position 't)
 '(scroll-margin 3))
;; frame end


;; html
(custom-set-variables
 '(sgml-basic-offset 4))

(defun my-html-xml-mode-settings ()
  (interactive)
  (imenu-add-menubar-index)
  (auto-fill-mode nil)
  (set (make-local-variable 'funclist-lang-exp) "id="))

(add-hook 'html-mode-hook 'my-html-xml-mode-settings)
(add-hook 'xml-mode-hook 'my-html-xml-mode-settings)

(defun my-pretty-print-xml-region (begin end)
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))
;; html end


;; kbd
(require 'cub-key-mode)
(cub-key-mode t)

(global-set-key "\r" 'newline-and-indent)
;; kbd end

;; php
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
;; php end


(require 'smartparens-config)
(smartparens-global-mode)
(show-smartparens-global-mode t)

(require 'expand-region)
(global-set-key (kbd "C-l") 'er/expand-region)

(global-anzu-mode +1)

(global-diff-hl-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(smex-initialize)

(load-theme 'zenburn t)
;; (load-theme 'flatland t)

(require 'auto-complete-config)
(ac-config-default)

(setq ac-sources '(ac-source-filename
                   ac-source-functions
                   ac-source-yasnippet
                   ac-source-variables
                   ac-source-symbols
                   ac-source-features
                   ac-source-abbrev
                   ac-source-dictionary
                   ac-source-words-in-same-mode-buffers
                   ac-source-words-in-all-buffer
                   ))

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))

(require 'yasnippet)
(yas-global-mode 1)
