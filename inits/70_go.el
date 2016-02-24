;; golang
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-f") 'gofmt))
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-g") 'go-goto-imports))
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports))
(add-hook 'go-mode-hook '(lambda ())
  (local-set-key (kbd "C-c C-k") 'godoc))

(require 'company)
(require 'company-go)                                ; load company mode go backend
(add-hook 'go-mode-hook 'company-mode)


;;; flycheck
(add-hook 'go-mode-hook 'flycheck-mode)
