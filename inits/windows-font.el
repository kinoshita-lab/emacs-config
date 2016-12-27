;;; font
;; theme これさきにやらないと変になる
(load-theme 'clarity t t)
(enable-theme 'clarity)
(set-face-attribute 'default nil
					:font "Terminus"
					:weight 'regular
          :height 160)
;; 日本語あああイイイ
(set-fontset-font nil 'japanese-jisx0208
				  (font-spec :family "ＭＳ ゴシック"))

(dolist (elt '(
			   ("*ＭＳ ゴシック*" . 0.8)
			   ))
  (add-to-list 'face-font-rescale-alist elt))

(setq-default line-spacing .01)
(set-face-attribute 'mode-line nil  :height 120)
