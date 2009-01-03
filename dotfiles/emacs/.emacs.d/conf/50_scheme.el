(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


;; scheme-complete
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(progn
     (define-key scheme-mode-map "\e\t" 'scheme-smart-complete)
     (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)))

(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
          (lambda ()
            (setq default-scheme-implementation 'gauche)
            (setq *current-scheme-implementation* 'gauche)
            (make-local-variable 'eldoc-documentation-function)
            (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
            (eldoc-mode)))
