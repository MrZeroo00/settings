;; uniquify (add directory name)
(require 'uniquify nil t)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; tempbuf
;(install-elisp-from-emacswiki "tempbuf.el")
;(require 'tempbuf nil t)
;(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
;(add-hook 'Man-mode-hook 'turn-on-tempbuf-mode)


;; contentswitch
;(install-elisp-from-emacswiki "contentswitch.el")
;(require 'contentswitch nil t)


;; macros
(load "_my-make-scratch")
(add-hook 'after-save-hook
          ;; when save *scratch* buffer, create new *scratch* buffer
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch t)))))
