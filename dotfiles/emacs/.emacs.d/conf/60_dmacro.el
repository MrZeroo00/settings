;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(defconst *dmacro-key* "\C-t" "�J�Ԃ��w��L�[")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)
