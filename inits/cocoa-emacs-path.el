;; load environment variables
;; 追記 GEMに関する環境変数を設定すると rbenv経由で rubyがうまく使えなかったので削除
(require 'exec-path-from-shell)
(let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))
(setq ripgrep-executable "/usr/local/bin/rg")
