;;;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(my-autoload-and-when 'dmacro-exec "dmacro"
                      (defconst *dmacro-key* "\C-t" "繰返し指定キー")
                      (global-set-key *dmacro-key* 'dmacro-exec))
