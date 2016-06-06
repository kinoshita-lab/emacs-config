(if window-system (progn
                    ;;; window size
                    ;;; color themes
                    (require 'color-theme)
                    (color-theme-initialize)
                    (load-theme 'monokai t)
                    (tool-bar-mode 0); toolbarいらない
                    (define-key global-map [ns-drag-file] 'ns-find-file)
                    (setq ns-pop-up-frames nil)
		    ;; font
					(set-face-attribute 'default nil :family "Rounded M+ 1m" :weight 'light :height 180)
					 ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m light"))
                    (setq-default line-spacing .01)
                    ))
