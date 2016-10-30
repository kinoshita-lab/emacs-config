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
              
;; ;; ctags
;; ;;;; for ctags.el
;; (require 'ctags)
;; (setq tags-revert-without-query t)
;; (setq ctags-command "ctags -Re --fields=\"+afikKlmnsSzt\" ")
;; ;;(setq ctags-command "ctags -Re --fields=+iaSt --extra=+q −−c++−kinds=+p")
;; (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
;; (global-set-key (kbd "M-.") 'ctags-search)

;; gtags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
 
;; use helm
(setq ggtags-completing-read-function nil)
 
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
(custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))

(setq company-idle-delay 0)


(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))
;; Only needed on Windows
(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0))


;; flycheck
(add-hook 'c-mode-common-hook 'flycheck-mode)

(require 'gud)

(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer t)
(add-hook
 'gdb-mode-hook
 '(lambda ()
    (gud-tooltip-mode t)
    (gud-def gud-break-main "break main" nil "Set breakpoint at main.")
 ))
(setq gud-tooltip-echo-area nil)

(define-key gud-minor-mode-map (kbd "<f1>") 'gud-print)
(define-key gud-minor-mode-map (kbd "<S-f1>") 'gud-watch)
(define-key gud-minor-mode-map (kbd "<f2>") 'gud-refresh)
(define-key gud-minor-mode-map (kbd "<f5>") 'gud-cont)
(define-key gud-minor-mode-map (kbd "<S-f5>") 'gud-kill)
(define-key gud-minor-mode-map (kbd "<f6>") 'gud-until)
(define-key gud-minor-mode-map (kbd "<f9>") 'gdb-set-clear-breakpoint)
(define-key gud-minor-mode-map (kbd "<S-f9>") 'gud-break-main)
(define-key gud-minor-mode-map (kbd "<f10>") 'gud-next)
(define-key gud-minor-mode-map (kbd "<f11>") 'gud-step)
(define-key gud-minor-mode-map (kbd "<C-f10>") 'gud-until)
(define-key gud-minor-mode-map (kbd "<C-f11>") 'gud-finish)
(define-key gud-minor-mode-map (kbd "<S-f11>") 'gud-finish)

(defun gdb-set-clear-breakpoint ()
  (interactive)
  (if (or (buffer-file-name) (eq major-mode 'gdb-assembler-mode))
      (if (or
           (let ((start (- (line-beginning-position) 1))
                 (end (+ (line-end-position) 1)))
             (catch 'breakpoint
               (dolist (overlay (overlays-in start end))
                 (if (overlay-get overlay 'put-break)
                     (throw 'breakpoint t)))))
           (eq (car (fringe-bitmaps-at-pos)) 'breakpoint))
          (gud-remove nil)
        (gud-break nil))))

(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  (kill-process (get-buffer-process gud-comint-buffer)))
