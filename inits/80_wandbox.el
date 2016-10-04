;; .emacs sample
(require 'wandbox)
(global-set-key (kbd "C-c w w") 'wandbox)
(global-set-key (kbd "C-c w e") 'wandbox-eval-last-sexp)
(global-set-key (kbd "C-c w l") 'wandbox-list-compilers)