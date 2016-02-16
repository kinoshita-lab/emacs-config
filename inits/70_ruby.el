;; ruby
;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files" t)
;; (setq auto-mode-alist
;;       (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;; (require 'ruby-electric)
;; (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;; (require 'robe)
;; (add-hook 'ruby-mode-hook
;;           '(lambda ()
;;              (robe-mode))
;;        (inf-ruby-keys))
