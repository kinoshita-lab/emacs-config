(if window-system 
	(progn
;; font
	  (set-face-attribute 'default nil :family "Rounded M+ 1m" :weight 'light :height 180)
	  (set-fontset-font (frame-parameter nil 'font)
						'japanese-jisx0208
						'("Rounded M+ 1m" . "unicode-bmp"))
	  (set-fontset-font (frame-parameter nil 'font)
						'katakana-jisx0201
						'("Rounded M+ 1m" . "unicode-bmp"))
	  (setq-default line-spacing .01)
	  ;; theme
	  (load-theme 'tangotango t)
	  ))


