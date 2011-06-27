(setq load-path (cons "~/.emacs.d" load-path))
(setq load-path (cons "~/.emacs.d/site-packages" load-path))
(setq load-path (cons "~/.emacs.d/site-packages/color-theme" load-path))
(setq load-path (cons "~/.emacs.d/site-packages/yasnippet" load-path))
(setq load-path (cons "~/.emacs.d/site-packages/emacs-jabber" load-path))
(setq load-path (cons "~/.emacs.d/site-packages/twittering-mode" load-path))
(setq load-path (cons "~/.emacs.d/site-packages/org-mode/lisp" load-path))

(setq user-emacs-directory "~/.dotfiles/emacs.d")

(require 'flymake)
(require 'yasnippet-bundle)
(require 'color-theme)

(load "~/.emacs.d/rc/ido.el")
;; (load "~/.emacs.d/rc/dired.el")
(load "~/.emacs.d/rc/edit.el")
(load "~/.emacs.d/rc/completion.el")
(load "~/.emacs.d/rc/colors.el")
(load "~/.emacs.d/rc/file-cache.el")
(load "~/.emacs.d/rc/files.el")
(load "~/.emacs.d/rc/frame.el")
(load "~/.emacs.d/rc/text.el")
(load "~/.emacs.d/rc/html.el")
(load "~/.emacs.d/rc/c.el")
(load "~/.emacs.d/rc/javascript.el")
(load "~/.emacs.d/rc/php.el")
(load "~/.emacs.d/rc/python.el")
(load "~/.emacs.d/rc/kbd.el")
(load "~/.emacs.d/rc/speedbar.el")
(load "~/.emacs.d/rc/lisp.el")
(load "~/.emacs.d/rc/growl.el")
(load "~/.emacs.d/rc/jabber.el")
(load "~/.emacs.d/rc/twitter.el")
(load "~/.emacs.d/rc/erc.el")
(load "~/.emacs.d/rc/org.el")
(load "~/.emacs.d/rc/pass.el")
(load "~/.emacs.d/site-packages/workspaces.el")

;; (desktop-save-mode 1)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; (custom-set-faces
;;  '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Inconsolata")))))


(server-start)
