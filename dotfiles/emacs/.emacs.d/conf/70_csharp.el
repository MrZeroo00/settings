(my-autoload-and-when 'csharp-mode "csharp-mode"
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))


;;;; mode hook
(defun my-csharp-mode-hook ()
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)


;; -*-no-byte-compile: t; -*-
