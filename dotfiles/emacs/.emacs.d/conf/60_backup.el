(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/etc/backup/emacs"))
            backup-directory-alist))
