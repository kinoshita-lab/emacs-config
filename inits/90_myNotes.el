(setq note-folder "~/Dropbox/notes")

;; 会社
(if (equal (system-name) "host1105")
	(setq note-folder "c:/Users/saita/Dropbox/notes"))

;; f1でnoteを開く
(global-set-key [f1] '(lambda () 
						(interactive)
						(find-file note-folder)))

