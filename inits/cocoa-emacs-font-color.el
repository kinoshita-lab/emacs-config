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
					 ;; 日本語あああイイイ
					(set-fontset-font nil 'japanese-jisx0208
									  (font-spec :family "Rounded M+ 1m light"))					
					;(set-face-attribute 'default nil :family "Envy Code B 10pt" :height 180)
					(set-face-attribute 'default nil :family "Envy Code R" :height 180)

                    (setq-default line-spacing .1)
                    ))
