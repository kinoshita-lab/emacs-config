;; Set your lisp system and, optionally, some contribs
(require 'slime)
(require 'slime-company)
 (setq inferior-lisp-program "clisp")
 (setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-company))
