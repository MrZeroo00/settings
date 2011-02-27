'(global-auto-revert-mode)
'(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*Occur*"))


;;;; uniquify (add directory name)
(my-require-and-when 'uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*"))
'(setq uwpn-project-root-alist
      '(("/opt/t/prj1" . "Project A")
        ("/opt/t/prj2" . "Project B")
        ;;("" . "")
        ))
(my-require-and-when 'uniquify_with_project_name)


;;;; midnight
(my-require-and-when 'midnight)


;;;; tempbuf
;;;(install-elisp-from-emacswiki "tempbuf.el")
'(my-require-and-when 'tempbuf
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
  (add-hook 'Man-mode-hook 'turn-on-tempbuf-mode))


;;;; contentswitch
;;;(install-elisp-from-emacswiki "contentswitch.el")
'(my-require-and-when 'contentswitch)


;;;; macros
(my-load-and-when "_my-kill-buffers")
(my-load-and-when "_my-save-and-kill-buffer")
'(my-load-and-when "_my-make-scratch"
  (add-hook 'after-save-hook
            ;; when save *scratch* buffer, create new *scratch* buffer
            (function (lambda ()
                        (unless (member "*scratch*" (my-buffer-name-list))
                          (my-make-scratch t))))))
