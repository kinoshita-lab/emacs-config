;;;; C
;; 自動改行+インデント
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             (c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)))
             
(add-hook 'c-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "k&r")
             (setq indent-tabs-mode t)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0))) ; 関数の引数リストの閉じ括弧はインデントしない

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))
              
;; ctags
;;;; for ctags.el
(require 'ctags)
(setq tags-revert-without-query t)
(setq ctags-command "ctags -Re --fields=+iaSt --extra=+q −−c++−kinds=+p")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
(global-set-key (kbd "M-.") 'ctags-search)

;; irony
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加
(custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
;; Only needed on Windows
(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0))


