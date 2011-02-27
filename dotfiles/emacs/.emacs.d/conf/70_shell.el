;;;; flymake
(my-require-and-when 'flymake-shell)


;;;; auto-insert
(when (featurep 'autoinsert)
  (add-to-list 'auto-insert-alist '("\\.sh$" . ["template.sh"
                                                (lambda() (my-template-exec "/bin/sh"))
                                                my-template]))
  )


;;;; mode hook
(defun my-sh-mode-hook ()
  ;; flymake-shell
  (when (featurep 'flymake-shell)
    (flymake-shell-load)
    )
  )
(add-hook 'sh-mode-hook 'my-sh-mode-hook)
