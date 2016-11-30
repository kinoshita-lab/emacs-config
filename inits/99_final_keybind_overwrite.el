;; overwrite DWIM key bindings!!!
(require 'bind-key)
;; tabber
(bind-key* (kbd "M-<right>") 'tabbar-forward-tab)
(bind-key* (kbd "M-<left>") 'tabbar-backward-tab)

;; eclipse-like header/impl switcher
(bind-key* (kbd "<C-tab>") 'ff-find-other-file)
