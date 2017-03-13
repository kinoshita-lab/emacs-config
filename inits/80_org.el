(require 'org)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; キー関係
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; TILにしかつかわない設定
(setq org-capture-templates
      '(("t" "TIL" entry (file+datetree org-file) "* %?\n  %i\n")))



;; org wiki
(require 'org-wiki)

;; should be override on windows environment
;; for MobileOrg
(setq org-directory "~/Dropbox/notes/til")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-files
      (list "~/Dropbox/notes/til/inbox.org"
			"~/Dropbox/notes/til/guchi.org"
            ))
(setq org-mobile-inbox-for-pull "~/Dropbox/notes/til/from_mobile.org")
