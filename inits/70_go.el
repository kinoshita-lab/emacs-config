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
;; 諸々の有効化、設定
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda()
           (add-hook 'before-save-hook' 'gofmt-before-save)
           (local-set-key (kbd "M-.") 'godef-jump)
           (set (make-local-variable 'company-backends) '(company-go))
           (company-mode)
           (setq indent-tabs-mode nil)    ; タブを利用
           (setq c-basic-offset 4)        ; tabサイズを4にする
           (setq tab-width 4)))
