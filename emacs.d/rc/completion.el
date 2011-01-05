(custom-set-variables
 '(comint-completion-addsuffix t)
 '(completion-ignored-extensions (remove ".svn-base" completion-ignored-extensions))
 '(compilation-window-height 10))

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev-visible
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-expand-whole-kill
		try-complete-file-name-partially
		try-complete-file-name
		try-complete-lisp-symbol-partially
		try-complete-lisp-symbol))

(put 'set-goal-column 'disabled nil)
(put 'dired-find-metaernate-file 'disabled nil)
(put 'upcase-region 'disabled nil)
