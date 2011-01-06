(autoload 'php-mode "php-mode" "PHP mode" t)

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))

;(setq php-mode-force-pear t)


;;;; gtags
(add-hook 'php-mode-user-hook (lambda ()
                           (gtags-mode t)
                           ;;(gtags-make-complete-list)
                           ))
