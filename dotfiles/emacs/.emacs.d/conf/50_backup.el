(setq make-backup-files t)
(setq version-control t)
(setq kept-new-versions 2)
(setq kept-old-versions 2)
(setq delete-old-versions t)
(setq delete-auto-save-files t)
(add-to-list 'backup-directory-alist (cons "\\.*$" (expand-file-name "~/etc/backup/emacs")))


;;;; multiverse
;;;; http://d.hatena.ne.jp/rubikitch/20081218/multiverse
;;;(install-elisp-from-emacswiki "multiverse.el")
'(my-require-and-when 'multiverse
  (defun my-save-buffer (arg)
    (interactive "P")
    (if arg
        (multiverse-store)
      (save-buffer)))

  (global-set-key "\C-x\C-s" 'my-save-buffer))


;; -*-no-byte-compile: t; -*-
