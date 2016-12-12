(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'tangotango t)
	  ;; font
	  (set-face-attribute 'default nil
					:font "Terminus"
					:weight 'regular
          :height 160)
	  ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m light"))
	  ))


(require 'mozc)
(setq default-input-method "japanese-mozc")
	  


