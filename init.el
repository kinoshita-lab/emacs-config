;;; 
;; Basic configurations

;; server
; server start for emacs-client
(require 'server)
(unless (server-running-p)  (server-start))




;;; load path
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elpa") load-path))

(setq load-path
      (cons (expand-file-name "~/.emacs.d/site-lisp") load-path))

(setq load-path
      (cons (expand-file-name "~/.emacs.d/site-lisp/howm-1.4.3") load-path))

;; add melpa and marmalade to elpa system
(fset 'package-desc-vers 'package--ac-desc-version)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
(setq url-http-attempt-keepalives nil)

(require 'init-loader)
;;(setq init-loader-show-log-after-init nil)
;; (defun init-loader-re-load (re dir &optional sort)
;;   (let ((load-path (cons dir load-path)))
;;     (dolist (el (init-loader--re-load-files re dir sort))
;;       (condition-case e
;;           (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
;;             (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
;;         (error
;;          ;; (init-loader-error-log (error-message-string e)) ；削除
;;          (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
;;          )))))
(init-loader-load "~/.emacs.d/inits")
;;(init-loader-load)
             
;; M-x customizes
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eww-search-prefix "https://www.google.co.jp/search?q=")
 '(package-selected-packages
   (quote
	(rainbow-delimiters tuareg helm-ag quack smartparens powerline tangotango-theme color-theme-tangotango dracula-theme company-irony markdown-mode+ merlin yasnippet-bundle yascroll tabbar sr-speedbar ruby-tools ruby-end ruby-electric ruby-block ruby-additional popwin minimap init-loader idle-require helm-make helm-descbinds go-eldoc go-direx git-rebase-mode git-gutter git-commit-mode git-commit flycheck-rust dired+ darcula-theme ctags csharp-mode company-go color-theme-monokai clojure-mode-extra-font-locking clojure-cheatsheet clj-refactor cdb ccc cargo bind-key ag 4clojure)))
 '(projectile-enable-caching t)
 '(quack-default-program "gosh -i")
 '(quack-fontify-style nil)
 '(quack-manuals
   (quote
	((r6rs "R5RS" "http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-2.html#node_toc_start" nil)
	 (gauche "Gauche Reference Manual" "http://practical-scheme.net/gauche/man/gauche-refj.html" nil)
	 (tspl "Scheme Programming Language (Dybvig)" "http://www.scheme.com/tspl/" nil)
	 (sicp "Structure and Interpretation of Computer Programs(JP)" "http://sicp.iijlab.net/fulltext/xcont.html" nil))))
 '(quack-pretty-lambda-p nil)
 '(quack-programs
   (quote
	("gosh -i" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-smart-open-paren-p nil)
 '(quack-tabs-are-evil-p nil)
 '(sr-speedbar-default-width 25))
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(quack-pltish-colon-keyword-face ((t (:foreground "DeepSkyBlue2" :weight bold))))
 '(quack-pltish-comment-face ((t (:foreground "SpringGreen2"))))
 '(quack-pltish-defn-face ((t (:foreground "SkyBlue2" :weight bold))))
 '(quack-pltish-keyword-face ((t (:foreground "DeepSkyBlue1" :weight bold))))
 '(quack-pltish-paren-face ((t (:foreground "LightSteelBlue1"))))
 '(quack-pltish-selfeval-face ((t (:foreground "gray60")))))
