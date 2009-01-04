;; uniquify (add directory name)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; macros
(load "_my-make-scratch")
(add-hook 'after-save-hook
          ;; when save *scratch* buffer, create new *scratch* buffer
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch t)))))
