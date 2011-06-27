;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "#FFFED8")

;; (set-background-color "white")
;; (set-foreground-color "black")

;; (color-theme-initialize)
;; (color-theme-charcoal-black)

;; (custom-set-faces
 ;; '(font-lock-comment-face ((t (:foreground "#555555"))))
 ;; '(font-lock-string-face ((t (:foreground "darkred"))))
 ;; '(font-lock-variable-name-face ((t (:foreground "darkblue"))))
 ;; '(font-lock-warning-face ((t (:foreground "red" :bold nil))))
 ;; '(mode-line ((t (:background "#2E3436" :foreground "#eeeeec"))))
 ;; '(diff-added ((t (:foreground "DarkBlue"))) t)
 ;; '(diff-removed ((t (:foreground "DarkRed"))) t)
 ;; '(font-lock-comment-face ((t (:foreground "#555555"))))
 ;; '(font-lock-string-face ((t (:foreground "darkred"))))
 ;; '(font-lock-variable-name-face ((t (:foreground "darkblue"))))
 ;; '(font-lock-warning-face ((t (:foreground "red" :bold nil))))
 ;; '(mode-line ((t (:background "#2E3436" :foreground "#eeeeec")))))

(require 'color-theme)
(color-theme-initialize)

(load "~/.emacs.d/site-packages/zenburn.el")
(color-theme-zenburn)

;; (require 'color-theme-solarized)
;; (color-theme-solarized-light)
;; (color-theme-solarized-dark)
