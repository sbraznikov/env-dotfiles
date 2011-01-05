(require 'filecache)

(setq file-cache-filter-regexps
      (quote("~$" "\\.o$" "\\.exe$" "\\.a$" "\\.elc$" ",v$"
	     "\\.output$" "\\.$" "#$" "\\.class$" "\\.pyc$" "\\.png$" "\\.jpg$" "\\.gif$"
	     "\\.svn$" "\\.svn-base$")))

(defun my-add-project-to-file-cache (dir)
  (interactive "DAdd directory: ")
  (file-cache-clear-cache)
  (file-cache-add-directory-recursively dir))

(defun file-cache-add-this-file ()
  (and buffer-file-name
       (file-exists-p buffer-file-name)
       (file-cache-add-file buffer-file-name)))

(defun my-file-cache-ido-file ()
  (interactive)
  (let* ((file (my-file-cache-ido-read "File: "
				       (mapcar
					(lambda (x)
					  (car x))
					file-cache-alist)))
	 (record (assoc file file-cache-alist)))
    (find-file
     (concat
      (if (= (length record) 2)
	  (car (cdr record))
	(my-file-cache-ido-read
	 (format "Find %s in dir: " file) (cdr record))) file))))

(defun my-file-cache-ido-read (prompt choices)
  (let ((ido-make-buffer-list-hook
	 (lambda ()
	   (setq ido-temp-list choices))))
    (ido-read-buffer prompt)))

(add-hook 'kill-buffer-hook 'file-cache-add-this-file)
