;; flymake
(my-require-and-when 'flymake-shell)


;;;; mode hook
(defun my-sh-mode-hook ()
  ;; flymake-shell
  (when (featurep 'flymake-shell)
    (flymake-shell-load)
    )
  )
(add-hook 'sh-mode-hook 'my-sh-mode-hook)


;; -*-no-byte-compile: t; -*-
