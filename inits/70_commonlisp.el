;; Set your lisp system and, optionally, some contribs

;; use roswell
(load (expand-file-name "~/.roswell/helper.el"))

(require 'slime-company)
 (setq inferior-lisp-program "clisp")
 (setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-company slime-banner))
