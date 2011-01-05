;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

;; (add-to-list 'load-path "~/opt/slime")
(require 'slime)
(slime-setup)
