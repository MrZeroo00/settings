;; dsvn
;(install-elisp "http://svn.collab.net/repos/svn/trunk/contrib/client-side/emacs/dsvn.el")
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)


;; egg
;(install-elisp "http://github.com/bogolisk/egg/raw/master/egg.el")
(require 'egg)
;(install-elisp "http://github.com/bogolisk/egg/raw/master/egg-grep.el")
(load "egg-grep")


;; p4
;; http://p4el.sourceforge.net/
;(load-library "p4")
