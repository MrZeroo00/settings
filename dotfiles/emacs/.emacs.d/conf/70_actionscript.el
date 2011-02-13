(my-autoload-and-when 'actionscript-mode "actionscript-mode")

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

;;;; mode hook
(defun my-actionscript-mode-hook (my-load-and-when "as-config"))
(add-hook 'actionscript-mode-hook 'my-actionscript-mode-hook)


;; -*-no-byte-compile: t; -*-
