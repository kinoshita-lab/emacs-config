(if window-system
	(progn
	  ;; theme これさきにやらないと変になる
	  (load-theme 'clarity t t)
	  (enable-theme 'clarity)
	  ;; font
	  (set-face-attribute 'default nil
					:font "Terminus"
					:weight 'regular
          :height 160)
	  ;; 日本語あああイイイ
	  (set-fontset-font nil 'japanese-jisx0208
						(font-spec :family "Rounded M+ 1m medium"))
	  (dolist (elt '(
					 ("Rounded M+*" . 0.8)
					 ))
		(add-to-list 'face-font-rescale-alist elt))))
	  


;; uim
;; read uim.el
(require 'uim)
;; uncomment next and comment out previous to load uim.el on-demand
;; (autoload 'uim-mode "uim" nil t)

;; key-binding for activate uim (ex. C-\)
(global-set-key "\C-\\" 'uim-mode)
;; set inline candidates displaying mode as default
(setq uim-candidate-display-inline t)

;; Set Hiragana input mode at activating uim.
(setq uim-default-im-prop '("action_anthy_utf8_hiragana"
                            "action_google-cgiapi-jp_hiragana"
                            "action_mozc_hiragana"))
