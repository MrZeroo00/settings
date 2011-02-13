;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/systemtap-mode/systemtap-mode.el")
(my-autoload-and-when 'systemtap-mode "systemtap-mode"
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("¥¥.stp¥¥'" . systemtap-mode))


;; -*-no-byte-compile: t; -*-
