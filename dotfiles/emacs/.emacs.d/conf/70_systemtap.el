;(install-elisp "http://svn.coderepos.org/share/lang/elisp/systemtap-mode/systemtap-mode.el")
(autoload 'systemtap-mode "systemtap-mode")

; association setting
(add-to-list 'auto-mode-alist '("¥¥.stp¥¥'" . systemtap-mode))
