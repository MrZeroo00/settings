;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(defconst *dmacro-key* "\C-t" "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)
