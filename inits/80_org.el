(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; キー関係
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; TILにしかつかわない設定
(setq org-capture-templates
      '(("t" "TIL" entry (file+datetree org-file) "* %?\n  %i\n")))



