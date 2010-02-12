;;;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(my-autoload-and-when 'dmacro-exec "dmacro"
                      (defconst *dmacro-key* "\C-t" "åJï‘ÇµéwíËÉLÅ[")
                      (global-set-key *dmacro-key* 'dmacro-exec))
