;(install-elisp "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
(autoload 'dmacro-exec "dmacro" nil t)

(defconst *dmacro-key* "\C-t" "�J�Ԃ��w��L�[")
(global-set-key *dmacro-key* 'dmacro-exec)
