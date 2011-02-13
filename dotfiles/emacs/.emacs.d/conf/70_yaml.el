;;;; http://yaml-mode.clouder.jp/
(my-autoload-and-when 'yaml-mode "yaml-mode"
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;;;; mode hook
(defun my-yaml-mode-hook ()
  (define-key yaml-mode-map "\C-m" 'newline-and-indent)
  )
(add-hook 'yaml-mode-hook 'my-yaml-mode-hook)


;; -*-no-byte-compile: t; -*-
