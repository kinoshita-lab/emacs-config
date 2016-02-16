;; golang
(require 'go-mode)
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-f") 'gofmt))
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-g") 'go-goto-imports))
(add-hook 'go-mode-hook '(lambda ())
               (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports))
(add-hook 'go-mode-hook '(lambda ())
  (local-set-key (kbd "C-c C-k") 'godoc))

(require 'company-go)                                ; load company mode go backend
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ())
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode))
