(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'tangotango t)
	  ;; font
	  (set-face-attribute 'default nil
					:font "Rounded M+ 1m light"
					:weight 'light
          :height 160)
	  ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m light"))
	  (setq-default line-spacing .02)))
	  


