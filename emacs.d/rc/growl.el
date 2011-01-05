(defvar growl-program "/usr/local/bin/growlnotify")

(defun growl (title message &optional id)
  (if (eq id nil)
      (start-process "growl" " growl"
                     growl-program title "-w")
    (start-process "growl" " growl"
                   growl-program title "-w" "-d" id))
  (process-send-string " growl" message)
  (process-send-string " growl" "\n")
  (process-send-eof " growl"))
