;;; 
;; Basic configurations

;; workaround for 'reference to free variable helm-alive-p
(defvar helm-alive-p)

;; install org-wiki via following code
;; (let ((url "https://raw.githubusercontent.com/caiorss/org-wiki/master/org-wiki.el"))     
;;       (with-current-buffer (url-retrieve-synchronously url)
;; 	(goto-char (point-min))
;; 	(re-search-forward "^$")
;; 	(delete-region (point) (point-min))
;; 	(kill-whole-line)
;; 	(package-install-from-buffer)))
;; server
; server start for emacs-client
(require 'server)
(server-force-delete)
(unless (server-running-p)  (server-start))

;;; load path
(setq load-path
      (cons (expand-file-name "~/.emacs.d/elpa") load-path))

(setq load-path
      (cons (expand-file-name "~/.emacs.d/site-lisp") load-path))

(setq load-path
      (cons (expand-file-name "~/.emacs.d/site-lisp/howm-1.4.3") load-path))

(add-to-list 'load-path "~/.emacs.d/site-lisp/el-go")

;; add melpa and marmalade to elpa system
(fset 'package-desc-vers 'package--ac-desc-version)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


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
 '(c-basic-offset 4)
 '(cc-other-file-alist
   (quote
	(("\\.cc\\'"
	  (".hh" ".h"))
	 ("\\.hh\\'"
	  (".cc" ".C"))
	 ("\\.c\\'"
	  (".h"))
	 ("\\.h\\'"
	  (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m"))
	 ("\\.C\\'"
	  (".H" ".hh" ".h"))
	 ("\\.H\\'"
	  (".C" ".CC"))
	 ("\\.CC\\'"
	  (".HH" ".H" ".hh" ".h"))
	 ("\\.HH\\'"
	  (".CC"))
	 ("\\.c\\+\\+\\'"
	  (".h++" ".hh" ".h"))
	 ("\\.h\\+\\+\\'"
	  (".c++"))
	 ("\\.cpp\\'"
	  (".hpp" ".hh" ".h"))
	 ("\\.hpp\\'"
	  (".cpp"))
	 ("\\.cxx\\'"
	  (".hxx" ".hh" ".h"))
	 ("\\.hxx\\'"
	  (".cxx"))
	 ("\\.m\\'"
	  (".h")))))
 '(custom-safe-themes
   (quote
	("08b8807d23c290c840bbb14614a83878529359eaba1805618b3be7d61b0b0a32" default)))
 '(eww-search-prefix "https://www.google.co.jp/search?q=")
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function
   (lambda
	 (errors)
	 (let
		 ((messages
		   (mapcar
			(function flycheck-error-message)
			errors)))
	   (popup-tip
		(mapconcat
		 (quote identity)
		 messages "
")))))
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages
   (quote
	(atom-one-dark-theme adoc-mode multi-term company-shell company-c-headers ddskk multiple-cursors pdf-tools yaml-mode flycheck org-wiki ox-html5slide gnugo uimage markdown-mode mozc helm-projectile ac-cider irony elscreen go-mode projectile-ripgrep color-theme-modern jedi-core clojure-mode color-theme ahungry-theme helm-smex parinfer magit flycheck-pos-tip flycheck-irony toml-mode dts-mode company-jedi helm-descbinds monokai-theme exec-path-from-shell helm-gtags cider projectile counsel jedi recentf-ext wandbox ripgrep racer company-racer rust-mode smartparens zeal-at-point emmet-mode js2-mode company-tern slime-company hydra company-irony-c-headers ggtags company-irony yasnippet-bundle company-go yasnippet company neotree win-switch avy rainbow-delimiters tuareg quack powerline tangotango-theme color-theme-tangotango dracula-theme markdown-mode+ merlin yascroll tabbar sr-speedbar ruby-tools ruby-end ruby-electric ruby-block ruby-additional popwin minimap init-loader idle-require go-eldoc go-direx git-gutter git-commit flycheck-rust dired+ darcula-theme ctags csharp-mode color-theme-monokai clojure-mode-extra-font-locking cdb ccc cargo bind-key ag 4clojure)))
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
 '(sr-speedbar-default-width 25)
 '(winner-mode t))
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit default :foreground "#FD971F" :underline t :weight bold :height 1.0))))
 '(org-level-2 ((t (:inherit default :foreground "#A6E22E" :weight bold :height 1.0))))
 '(org-level-3 ((t (:inherit default :foreground "#66D9EF" :weight bold :height 1.0))))
 '(org-level-4 ((t (:inherit default :foreground "#E6DB74" :weight normal :height 1.1))))
 '(org-level-5 ((t (:inherit default :foreground "#A1EFE4"))))
 '(org-level-6 ((t (:inherit default :foreground "#A6E22E"))))
 '(org-level-7 ((t (:inherit default :foreground "#F92672"))))
 '(org-level-8 ((t (:inherit default :foreground "#66D9EF"))))
 '(quack-pltish-colon-keyword-face ((t (:foreground "DeepSkyBlue2" :weight bold))))
 '(quack-pltish-comment-face ((t (:foreground "SpringGreen2"))))
 '(quack-pltish-defn-face ((t (:foreground "SkyBlue2" :weight bold))))
 '(quack-pltish-keyword-face ((t (:foreground "DeepSkyBlue1" :weight bold))))
 '(quack-pltish-paren-face ((t (:foreground "LightSteelBlue1"))))
 '(quack-pltish-selfeval-face ((t (:foreground "gray60")))))
