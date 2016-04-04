(if window-system 
	(progn
;; font
	  (set-face-attribute 'default nil :family "Rounded M+ 1m" :weight 'light :height 180)
	  (setq-default line-spacing .01)
	  ))
