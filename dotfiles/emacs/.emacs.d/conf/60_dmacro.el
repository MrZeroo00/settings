;;;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(my-autoload-and-when 'dmacro-exec "dmacro"
                      (defconst *dmacro-key* "\C-t" "�J�Ԃ��w��L�[")
                      (global-set-key *dmacro-key* 'dmacro-exec))
