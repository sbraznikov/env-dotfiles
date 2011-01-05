(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red"))
        ("WAIT" . (:foreground "orange" :weight bold))
        ("DONE" . (:foreground "darkgreen"))))

;; Set to the location of your Org files on your local system
(setq org-directory "~/.org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/.org/index.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;; (custom-set-variables
;;  '(org-agenda-files (quote ("~/Dropbox/MobileOrg/agenda.org")))
;;  '(org-default-notes-file "~/Dropbox/MobileOrg/note.org")
;;  '(org-directory "~/Dropbox/MobileOrg/")
;;  )

