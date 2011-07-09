(setq vc-follow-symlinks t)


;;;; psvn
;;;(install-elisp "http://www.xsteve.at/prg/emacs/psvn.el")
(my-autoload-and-when 'svn-status "psvn")
(my-autoload-and-when 'svn-update "psvn")
(setq svn-status-verbose nil)


;;;; magit
;;; http://philjackson.github.com/magit/
(my-require-and-when 'magit)


;;;; git-dwim
;;;(install-elisp-from-emacswiki "git-dwim.el")
(my-require-and-when 'git-dwim
  (global-set-key "\C-xvb" 'git-branch-next-action))


;; -*-no-byte-compile: t; -*-
