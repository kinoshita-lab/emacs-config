;; remove beautiful opening screen
(setq inhibit-startup-message t)

;; do not create backup files
(setq backup-inhibited t)
(setq make-backup-files 0)


;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(require 'linum)
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#bf616a"
                    :height 0.8)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))
;; 行番号フォーマット
(setq linum-format "%4d")


;; use idle-require
(require 'idle-require)


;; 細かい設定
;;(savehist-mode 1) ;; ミニバッファの履歴の保存数を増やす
(show-paren-mode 1)
(global-set-key (kbd "C-h") 'delete-backward-char)
(display-time)
(line-number-mode)
(column-number-mode)
(transient-mark-mode 1)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq message-log-max 10000)
;;(setq enable-recursive-minibuffers t)
(setq use-dialog-box 0)
(defalias 'message-box 'message)
(setq history-length 1000)
(setq echo-keystrokes 0.1)
(setq large-file-warning-threshold (* 25 1024 1024))
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
(defalias 'yes-or-no-p 'y-or-n-p)


(require 'dired+)
;; sr-speedbar
(require 'sr-speedbar)
(setq sr-speedbar-right-side 0) 
(defalias 'speedbar 'sr-speedbar-toggle)

;; 対応する括弧を表示する
(show-paren-mode t)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; スクロールバーいらない
(scroll-bar-mode -1)

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files 0)

;; .#* とかのバックアップファイルを作らない 
(setq auto-save-default 0)

(setq auto-save-list-file-prefix 0)
(setq create-lockfiles 0)

;; auto save
;(require 'auto-save-buffers)
;(run-with-idle-timer 0.5 t 'auto-save-buffers)


;; 俺設定
(global-set-key "\C-m" 'newline-and-indent)
;; "C-t" でウィンドウを切り替える。初期値はtranspose-chars
(define-key global-map (kbd "C-t") 'other-window)
;;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;; toolbarいらない
(tool-bar-mode 0)

;; その他
;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; バッファ自動再読み込み
(global-auto-revert-mode 1)


(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background  "#98FB98"))
    (t
     ()))
  "*Face used by hl-line.")

(setq hl-line-face 'hlline-face)
;; global-hl-line-modeをやめて高速化
;; via http://rubikitch.com/2015/05/14/global-hl-line-mode-timer/
(global-hl-line-mode 0)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)


;; 括弧の補完 with skeleton-pair
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)


;; tab = 4
(setq-default tab-width 4 indent-tabs-mode t)

;; ffap
(ffap-bindings)

;;ファイル名がぶつからないようにする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
