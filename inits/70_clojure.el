(require 'clojure-mode)

(require 'cider)
;; clojure-mode で cider を有効に
(add-hook 'clojure-mode-hook 'cider-mode)
;; eldoc を有効にする
;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; 色々出さないw
(setq cider-repl-display-help-banner nil)

(setq cider-cljs-lein-repl
	  "(do (require 'figwheel-sidecar.repl-api)
            (figwheel-sidecar.repl-api/start-figwheel!)
            (figwheel-sidecar.repl-api/cljs-repl))")

