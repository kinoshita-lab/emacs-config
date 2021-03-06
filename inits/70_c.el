;;;; C
;; 自動改行+インデント
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
			 (setq tab-width 4)
			 (setq c-basic-offset 4)
			 (setq indent-tabs-mode t)     
             (c-toggle-auto-hungry-state 1)
			 (c-toggle-auto-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)))
             
;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
			 (setq c-basic-offset 4)
             (define-key c++-mode-map "/" 'self-insert-command) ; javadoc風コメント
             (setq comment-style 'extra-line)
             (setq comment-continue " * ")
             (setq comment-start "/** ")
             (setq comment-end " */")
             ))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))
(add-hook 'c-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (setq tab-width 4)))              
;; ;; ctags
;; ;;;; for ctags.el
;; (require 'ctags)
;; (setq tags-revert-without-query t)
;; (setq ctags-command "ctags -Re --fields=\"+afikKlmnsSzt\" ")
;; ;;(setq ctags-command "ctags -Re --fields=+iaSt --extra=+q −−c++−kinds=+p")
;; (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
;; (global-set-key (kbd "M-.") 'ctags-search)


;; irony
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加
(require 'company-c-headers)


(setq irony-additional-clang-options (quote ("-std=c++11" "-stdlib=libc++")))
(setq company-backends (delete 'company-semantic company-backends))

(setq company-idle-delay .0)


;; irony c headers
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))
;; Only needed on Windows
(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0))

(add-hook 'prog-mode-hook
		  (lambda ()
			(add-to-list 'company-backends
						 '(company-irony-c-headers company-irony company-rtags))))

;; yasnippet
(require 'yasnippet)
(yas-reload-all)
;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "M-\\") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
(yas-global-mode 1)

(eval-after-load "yasnippet"
  '(progn
     ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
     (define-key yas-keymap (kbd "<tab>") nil)
     (yas-global-mode 1)))

;; flycheck
(require 'flycheck)
(add-hook 'c-mode-common-hook 'flycheck-mode)
(flycheck-define-checker c/c++11
  "A C/C++ checker using g++."
  :command ("g++" "-Wall" "-Wextra" "-std=c++11" "-Wno-pragma-once-outside-header" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " Error: " (message)
                           line-end)
                    (error line-start
                                 (file-name) ":" line ":" column ":" " Fatal Error: " (message)
                           line-end)
                    (warning line-start
                             (file-name) ":" line ":" column ":" " Warning: " (message)
                             line-end))
  :modes (c-mode c++-mode))
(add-hook 'c++-mode-hook
          '(lambda()
             (flycheck-select-checker 'c/c++11)))
(add-hook 'c++-mode-hook (lambda()
                           (setq flycheck-gcc-language-standard "c++11")
                           (setq flycheck-clang-language-standard "c++11")))
(when (require 'flycheck nil 'noerror)
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode))


(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(defun setup-flycheck-clang-project-path ()
  (let ((root (ignore-errors (projectile-project-root))))
    (when root
      (add-to-list 
       (make-variable-buffer-local 'flycheck-clang-include-path)
       root))))

(add-hook 'c++-mode-hook 'setup-flycheck-clang-project-path)

;; ggtags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(require 'helm-config)
(require 'helm-gtags)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
			 (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
			 (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
			 (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)))
;; use helm
;; (setq ggtags-completing-read-function nil)
 
;; use eldoc
(setq-local eldoc-documentation-function #'ggtags-eldoc-function)
 
;; imenu
(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
 
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
 
(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
