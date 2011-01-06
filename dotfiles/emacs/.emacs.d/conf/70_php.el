(autoload 'php-mode "php-mode" "PHP mode" t)

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))

;(setq php-mode-force-pear t)


;;;; gtags
(add-hook 'php-mode-user-hook (lambda ()
                           (gtags-mode t)
                           ;;(gtags-make-complete-list)
                           ))


;;;; php-completion
;;;(install-elisp-from-emacswiki "php-completion.el")
(add-hook 'php-mode-user-hook
          (lambda ()
            (my-require-and-when 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
            (when (require 'auto-complete nil t)
              (make-variable-buffer-local 'ac-sources)
              (add-to-list 'ac-sources 'ac-source-php-completion)
              (auto-complete-mode t))))
