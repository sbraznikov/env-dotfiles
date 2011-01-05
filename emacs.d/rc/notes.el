(defun my-todo ()
  (interactive)
  (find-file "~/.todo.txt"))

(defun my-notes ()
  (interactive)
  (find-file "~/.notes.txt"))

(defalias 'td 'my-todo)
(defalias 'nt 'my-notes)
