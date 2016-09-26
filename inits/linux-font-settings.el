(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'tangotango t)
	  ;; font
	  (set-face-attribute 'default nil :family "Rounded M+ 1m" :weight 'light :height 180)
	  ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m light"))
	  (setq-default line-spacing .01)))
	  


