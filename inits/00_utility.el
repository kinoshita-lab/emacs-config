; ホスト名
(defun get-host-name ()
	(setq hostname (getenv "HOSTNAME"))
  (if (null hostname)
	  (setq hostname (getenv "HOST")))
  (if (null hostname)
	  (setq hostname (getenv "COMPUTERNAME")))
  (if (null hostname)
	  (setq hostname "no_host"))
  ;; 小文字に
  (setq hostname (downcase hostname))
  hostname)



