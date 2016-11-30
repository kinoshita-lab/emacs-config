;; overwrite DWIM key bindings!!!
(require 'bind-key)
;; tabber
(bind-key* (kbd "M-<right>") 'tabbar-forward-tab)
(bind-key* (kbd "M-<left>") 'tabbar-backward-tab)

