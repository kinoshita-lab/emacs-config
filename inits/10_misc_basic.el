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

;; dired+
(require 'dired+)
(diredp-toggle-find-file-reuse-dir t)

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
(setq ripgrep-executable "/usr/bin/rg")
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
(elscreen-start)

;; popup
(require 'popup)

;; multiple-cursors
(require 'multiple-cursors)

;; asciidoc
(require 'adoc-mode)

;; clojure cookbook
(defun increment-clojure-cookbook ()
  "When reading the Clojure cookbook, find the next section, and
close the buffer. If the next section is a sub-directory or in
the next chapter, open Dired so you can find it manually."
  (interactive)
  (let* ((cur (buffer-name))
     (split-cur (split-string cur "[-_]"))
     (chap (car split-cur))
     (rec (car (cdr split-cur)))
     (rec-num (string-to-number rec))
     (next-rec-num (1+ rec-num))
     (next-rec-s (number-to-string next-rec-num))
     (next-rec (if (< next-rec-num 10)
               (concat "0" next-rec-s)
             next-rec-s))
     (target (file-name-completion (concat chap "-" next-rec) "")))
    (progn 
      (if (equal target nil)
      (dired (file-name-directory (buffer-file-name)))
    (find-file target))
      (kill-buffer cur))))
