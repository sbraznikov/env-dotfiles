;;; cub-key-mode.el

;; Copyright (C) 2008 Sergej Braznikov, Hannover, Germany

;; Maintainer: Sergej Braznikov <sb@ryotic.de>
;; Author: Sergej Braznikov 2008
;; Created: 2008-02-21
;; Modified: 2008-02-27
;; X-URL: http://sb.ryotic.de

;;; License

;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

(defvar cub-key-mode-map
  (let ((map (make-sparse-keymap)))
	(define-key map "\C-x\C-m" 'helm-M-x)

    (define-key map [(alt up)] 'beginning-of-buffer)
    (define-key map [(alt down)] 'end-of-buffer)
    (define-key map [(alt left)] 'beginning-of-line)
    (define-key map [(alt right)] 'end-of-line)

    (define-key map [(control up)] 'jump-3-line-up)
 	(define-key map [(control down)] 'jump-3-line-down)
	(define-key map [(control left)] 'backward-word)
	(define-key map [(control right)] 'forward-word)
	(define-key map [(control o)] 'org-agenda-list)

    (define-key map (kbd "A-1") 'delete-other-windows)
	(define-key map (kbd "A-2") 'split-window-vertically)
	(define-key map (kbd "A-3") 'other-window)
	(define-key map (kbd "A-4") 'split-window-horizontally)

	;; (define-key map [(backspace)] 'delete-backward-char)
	;; (define-key map [(control backspace)] 'backward-kill-word)

	(define-key map [(control d)] 'my-duplicate-current-line-or-region)
	(define-key map [(control f)] 'search-word-under-cursor)

	(define-key map [(alt j)] 'join-line)
	(define-key map [(alt e)] 'helm-buffers-list)
	(define-key map [(alt o)] 'helm-find-files)
	(define-key map [(alt shift w)] 'kill-buffer-and-window)
	(define-key map [(alt w)] 'kill-buffer)
    (define-key map [(alt s)] 'save-buffer)
    (define-key map [(alt i)] 'cub-key-open-finder-here)
    (define-key map [(alt q)] 'save-buffers-kill-emacs)
    (define-key map [(alt z)] 'undo-tree-undo)
    (define-key map [(alt shift z)] 'undo-tree-redo)
    (define-key map [(alt x)] 'clipboard-kill-region)
    (define-key map [(alt c)] 'clipboard-kill-ring-save)
    (define-key map [(alt v)] 'clipboard-yank)
	(define-key map [(alt a)] 'mark-whole-buffer)
    (define-key map [(alt f)] 'rgrep)
	(define-key map [(alt g)] 'goto-line)
	(define-key map [(alt l)] 'recenter)
	(define-key map [(alt \#)] 'cub-key-mode-comment-or-uncomment-region)
    map))

(defun cub-key-mode-comment-or-uncomment-region (arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not mark-active) (save-excursion (beginning-of-line) (not (looking-at "\\s-*$"))))
	  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  	(comment-dwim arg)))

(defun cub-key-mode-jump-to-match-forward()
  (interactive)
  (search-forward-regexp (current-word t))
  (recenter))

(defun cub-key-mode-jump-to-match-backward()
  (interactive)
  (search-backward-regexp (current-word t))
    (recenter))

(defun cub-key-open-finder-here()
  (interactive)
  (shell-command "open ."))

(defun cub-key-find-org-todo-file()
  (interactive)
  (find-file "~/Dropbox/MobileOrg/index.org"))

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;;;###autoload
(define-minor-mode cub-key-mode
  :global t
  :group 'cub-key-mode-map
  :keymap 'cub-key-mode-map

  (if cub-key-mode
	  (progn
		(setq mac-command-modifier 'alt)
		(setq mac-control-modifier 'control)
        ))

  (fset 'jump-3-line-up
		[up up up])

  (fset 'jump-3-line-down
		[down down down])

  (fset 'yes-or-no-p
		'y-or-n-p))

(provide 'cub-key-mode)
