(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/etc/backup/emacs"))
            backup-directory-alist))

(setq version-control t)
(setq kept-new-versions 2)
(setq kept-old-versions 2)
(setq delete-old-versions t)

(setq delete-auto-save-files t)
