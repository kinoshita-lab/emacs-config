;; (let ((str "The quick brown fox jumps over the lazy dog ´`''\"\"1lI|¦!Ø0Oo{[()]}.,:; あああいいいううう")
;;       (font-families (cl-remove-duplicates 
;; 		      (sort (font-family-list) 
;; 			    (lambda(x y) (string< (upcase x) (upcase y))))
;; 		      :test 'string=)))
;;   (dolist (ff font-families)
;;     (insert 
;;      (propertize str 'font-lock-face `(:family ,ff))               ff "\n"
;;      (propertize str 'font-lock-face `(:family ,ff :slant italic)) ff "\n")))


(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'atom-one-dark t)
	  ;;(enable-theme 'atom-one-dark)
	  
	  (set-face-attribute 'default nil
						  :font "Rounded M+ 1m light"
						  :height 120
						  )
	  ;; 日本語はlightだと読めない
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m regular"))
	  (setq-default line-spacing .1)
	  ))

