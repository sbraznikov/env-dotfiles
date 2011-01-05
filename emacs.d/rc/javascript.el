;; (autoload 'javascript-mode "javascript" nil t)

;; (defun my-javascript-mode-settings ()
;;   (interactive)
;;   ;; (define-key javascript-mode-map (kbd "TAB") 'self-insert-command)
;;   (set (make-local-variable 'funclist-lang-exp)
;;        "function\\s-+\\(\\w+\\)\\s-*("))

;; (add-hook 'javascript-mode-hook 'my-javascript-mode-settings)

;; (autoload 'js2-mode "js2" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
