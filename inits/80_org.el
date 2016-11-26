(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-file "~/Dropbox/org/index.org")

;; 会社
;; (if (equal (get-host-name) "host1105")
;; 	(setq org-file "C:/Users/saita/Dropbox/notes/note.org"))

;; キー関係
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; TILにしかつかわない設定
(setq org-capture-templates
      '(("t" "TIL" entry (file+datetree org-file) "* %?\n  %i\n")))

;; f1でindex.orgを開く
(global-set-key [f1] '(lambda () 
						(interactive)
						(find-file org-file)))



(setq org-startup-truncated t)
