(custom-set-variables
 '(sgml-basic-offset 4))

(defun my-html-xml-mode-settings ()
  (interactive)
  (imenu-add-menubar-index)
  (auto-fill-mode nil)
  (set (make-local-variable 'funclist-lang-exp) "id="))

(add-hook 'html-mode-hook 'my-html-xml-mode-settings)
(add-hook 'xml-mode-hook 'my-html-xml-mode-settings)
