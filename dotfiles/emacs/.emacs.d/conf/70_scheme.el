(my-autoload-and-when 'scheme-mode "cmuscheme")
(my-autoload-and-when 'run-scheme "cmuscheme")


;;;; scheme-complete
(my-autoload-and-when 'scheme-smart-complete "scheme-complete")
(my-autoload-and-when 'scheme-get-current-symbol-info "scheme-complete")


;;;; mode hook
(defun my-scheme-mode-hook ()
  ;; common setting
  (when (featurep 'cmuscheme)
    (setq default-scheme-implementation 'gauche)
    (setq *current-scheme-implementation* 'gauche)
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (eldoc-mode)

    (setq process-coding-system-alist
          (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

    (setq scheme-program-name "gosh -i")
    )

  ;; scheme-complete
  (when (featurep 'scheme-complete)
    (define-key scheme-mode-map "\e\t" 'scheme-smart-complete)
    (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)
    )
  )
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)


;; -*-no-byte-compile: t; -*-
