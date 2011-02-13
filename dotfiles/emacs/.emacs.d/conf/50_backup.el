(setq make-backup-files t)
(add-to-list 'backup-directory-alist (cons "\\.*$" (expand-file-name "~/etc/backup/emacs")))

(setq version-control t)
(setq kept-new-versions 2)
(setq kept-old-versions 2)
(setq delete-old-versions t)

(setq delete-auto-save-files t)


;; -*-no-byte-compile: t; -*-
