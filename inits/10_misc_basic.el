;; remove beautiful opening screen
(setq inhibit-startup-message t)

;; do not create backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-directory-alist '((".*" . "~/.ehist")))

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


;; ;; 細かい設定
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

;;sr-speedbar 
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq speedbar-show-unknown-files t)
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

;; 俺設定
(global-set-key "\C-m" 'newline-and-indent)
;; "C-t" でウィンドウを切り替える。初期値はtranspose-chars
;;(define-key global-map (kbd "C-t") 'other-window)
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

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; ;; 
(setq scroll-conservatively 1)
(setq scroll-margin 5)
(setq next-screen-context-lines 5)
(setq scroll-preserve-screen-position t)


;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode t)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;; 画像を使わないことで軽量化する
(setq tabbar-use-images nil)
;; キーに割り当てる
(global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
(global-set-key (kbd "M-<left>") 'tabbar-backward-tab)
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

;;----- 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;;----- 表示するバッファ
(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

(add-to-list 'Info-directory-list "~/info/")
(defun Info-find-node--info-ja (orig-fn filename &rest args)
  (apply orig-fn
         (pcase filename
           ("emacs" "emacs245-ja")
           (t filename))
         args))
(advice-add 'Info-find-node :around 'Info-find-node--info-ja) 

;; ripgrep
(require 'ripgrep)
;;; rgバイナリの位置
(setq ripgrep-executable "e:/share/bin/rg.exe")
;;; rgに渡すオプション
(setq ripgrep-arguments '("-S"))

;; recentf-ext
;; (require 'recentf-ext)
(require 'recentf)
(recentf-mode 1)

(setq recentf-max-saved-items 2000) ;; 2000ファイルまで履歴保存する
(setq recentf-auto-cleanup 'never)  ;; 存在しないファイルは消さない
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" "/\\.emacs\\.d/games/*-scores" "/\\.emacs\\.d/\\.cask/"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))

(recentf-mode 1)
(bind-key "C-c t" 'helm-recentf)

;; subword/superword
(setq global-subword-mode 1)
(setq global-superword-mode 1)

;; ブックマークを変更したら即保存する
(setq bookmark-save-flag 1)
;; 超整理法
(progn
  (setq bookmark-sort-flag nil)
  (defun bookmark-arrange-latest-top ()
    (let ((latest ( bookmark-get-bookmark bookmark)))
      (setq bookmark-alist (cons latest (delq latest bookmark-aliset))))
    (bookmark-save))
  (add-hook 'bookmark-after-jump-hook 'bookmark-arrange-latest-top))

;; http://stackoverflow.com/questions/3417438/closing-all-other-buffers-in-emacs
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
		(delq (current-buffer) 
			  (remove-if-not 'buffer-file-name (buffer-list)))))

;; elscreen
(require 'elscreen)
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
