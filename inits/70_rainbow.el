(require 'rainbow-delimiters)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
;; these setting should be placed after load-theme
;; using stronger colors
(require 'cl-lib)
(require 'color)
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
   (cl-callf color-saturate-name (face-foreground face) 30)))
;; ;; 関数にしないとうまくいかない...手動で有効に
;; (defun rainbow-delimiters-using-stronger-colors ()
;;   (interactive)
;;   (cl-loop
;;    for index from 1 to rainbow-delimiters-max-face-count
;;    do
;;    (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;;      (cl-callf color-saturate-name (face-foreground face) 100))))
 
;; making unmatched parens stand out more
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
            :foreground 'unspecified
            :inherit 'error
            :strike-through t)
