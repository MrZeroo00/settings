(my-autoload-and-when 'scheme-mode "cmuscheme")
(my-autoload-and-when 'run-scheme "cmuscheme")

; mode hook
(my-eval-after-load "cmuscheme"
  (add-hook 'scheme-mode-hook
            (lambda ()
              (setq default-scheme-implementation 'gauche)
              (setq *current-scheme-implementation* 'gauche)
              (make-local-variable 'eldoc-documentation-function)
              (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
              (eldoc-mode)))

  (setq process-coding-system-alist
        (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

  (setq scheme-program-name "gosh -i"))


;; scheme-complete
(my-autoload-and-when 'scheme-smart-complete "scheme-complete")
(my-autoload-and-when 'scheme-get-current-symbol-info "scheme-complete")
(add-hook 'scheme-mode-hook
          (lambda ()
            (define-key scheme-mode-map "\e\t" 'scheme-smart-complete)
            (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)))
