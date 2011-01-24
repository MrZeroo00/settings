(setq vc-follow-symlinks t)


;;;; psvn
;;;(install-elisp "http://www.xsteve.at/prg/emacs/psvn.el")
(my-autoload-and-when 'svn-status "psvn")
(my-autoload-and-when 'svn-update "psvn")


;;;; dsvn
;;;(install-elisp "http://svn.collab.net/repos/svn/trunk/contrib/client-side/emacs/dsvn.el")
;;;(my-autoload-and-when 'svn-status "dsvn")
;;;(my-autoload-and-when 'svn-update "dsvn")


;;;; egg
;;;(install-elisp "http://github.com/bogolisk/egg/raw/master/egg.el")
;;;(install-elisp "http://github.com/bogolisk/egg/raw/master/egg-grep.el")
(my-require-and-when 'egg
  (my-load-and-when "egg-grep")
  (define-key egg-file-cmd-map "z" 'egg-buffer-stash-wip)
  (define-key egg-file-cmd-map "Z" 'egg-stash-buffer-pop)

  (define-key egg-diff-section-map "d" 'egg-diff-section-cmd-ediff)
  (define-key egg-staged-diff-section-map "d" 'egg-staged-section-cmd-ediff3)
  (define-key egg-unstaged-diff-section-map "d" 'egg-unstaged-section-cmd-ediff)
  (define-key egg-unmerged-diff-section-map "d" 'egg-unmerged-section-cmd-ediff3)
  (define-key egg-hunk-section-map "d" 'egg-diff-section-cmd-ediff)
  (define-key egg-staged-hunk-section-map "d" 'egg-staged-section-cmd-ediff3)
  (define-key egg-unstaged-hunk-section-map "d" 'egg-unstaged-section-cmd-ediff)
  (define-key egg-unmerged-hunk-section-map "d" 'egg-unmerged-section-cmd-ediff3)
  (define-key egg-log-commit-map "d" 'egg-log-buffer-diff-revs)
  (define-key egg-log-diff-map "d" 'egg-diff-section-cmd-ediff)
  (define-key egg-log-hunk-map "d" 'egg-diff-section-cmd-ediff)

  (defun git-log-file ()
    (interactive)
    (shell-command (format "git log %s" buffer-file-name) "*git-log*"))
  (define-key egg-file-cmd-map "l" 'git-log-file))


;;;; git-dwim
;;;(install-elisp-from-emacswiki "git-dwim.el")
(my-require-and-when 'git-dwim)
(global-set-key "\C-xvb" 'git-branch-next-action)


;;;; p4
;;;; http://p4el.sourceforge.net/
;;;(my-require-and-when 'p4)
