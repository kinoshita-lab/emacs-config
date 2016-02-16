;;; homeからやりたい
(cd "~/")

;; exec path
(setq exec-path (parse-colon-path (getenv "PATH")))

;; server
(require 'server)
(unless (server-running-p)
  (server-start))

