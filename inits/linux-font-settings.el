(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'clarity t t)
	  (enable-theme 'clarity)
	  ;; font
	  (set-face-attribute 'default nil
					:font "Terminus"
					:weight 'regular
          :height 120)
	  ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m light"))
	  (dolist (elt '(
					 ("*Rounded M+*" . 0.8)
					 ))
		(add-to-list 'face-font-rescale-alist elt))))


(require 'mozc)
(setq default-input-method "japanese-mozc")
	  


