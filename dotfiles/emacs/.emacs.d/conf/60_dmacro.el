;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(defconst *dmacro-key* "\C-t" "ŒJ•Ô‚µw’èƒL[")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)
