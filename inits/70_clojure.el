(require 'clojure-mode)

(require 'cider)
;; clojure-mode で cider を有効に
(add-hook 'clojure-mode-hook 'cider-mode)
;; eldoc を有効にする
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; 色々出さない
(setq cider-repl-display-help-banner nil)

(require 'clojure-cheatsheet)
(define-key clojure-mode-map (kbd "C-c C-h") #'clojure-cheatsheet)


(require '4clojure)
(defadvice 4clojure-open-question (around 4clojure-open-question-around)
  "Start a cider/nREPL connection if one hasn't already been started when
opening 4clojure questions"
  ad-do-it
  (unless cider-current-clojure-buffer
    (cider-jack-in)))
