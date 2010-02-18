;;;; uniquify (add directory name)
(my-require-and-when 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))


;;;; tempbuf
;;;(install-elisp-from-emacswiki "tempbuf.el")
'(my-require-and-when 'tempbuf
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'Man-mode-hook 'turn-on-tempbuf-mode))


;;;; contentswitch
;;;(install-elisp-from-emacswiki "contentswitch.el")
;;;(my-require-and-when 'contentswitch)


;;;; macros
(my-load-and-when "_my-kill-buffers")
(my-load-and-when "_my-save-and-kill-buffer")
'(my-load-and-when "_my-make-scratch"
  (add-hook 'after-save-hook
            ;; when save *scratch* buffer, create new *scratch* buffer
            (function (lambda ()
                        (unless (member "*scratch*" (my-buffer-name-list))
                          (my-make-scratch t))))))
