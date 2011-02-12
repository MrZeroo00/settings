(autoload 'php-mode "php-mode" "PHP mode" t)

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))


;;;; common setting
;(setq php-mode-force-pear t)
(add-to-list 'which-func-modes 'php-mode)


;;;; anything
(add-hook 'php-mode-hook
          (lambda ()
			(make-variable-buffer-local 'anything-sources)
			;;(add-to-list 'anything-sources 'anything-c-source-yasnippet t)
			(add-to-list 'anything-sources 'anything-c-source-imenu t)
			;;(add-to-list 'anything-sources 'anything-c-source-gtags-select t)
			))


;;;; flymake
(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
		 (local (file-relative-name temp (file-name-directory buffer-file-name))))
	(list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
			 '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))


;;;; gtags
(add-hook 'php-mode-hook (lambda ()
                           (gtags-mode t)
                           ;;(gtags-make-complete-list)
                           ))


;;;; php-completion
;;;(install-elisp-from-emacswiki "php-completion.el")
(add-hook 'php-mode-hook
          (lambda ()
            (my-require-and-when 'php-completion
			  (php-completion-mode t)
			  ;;(define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
			  (when (my-require-and-when 'auto-complete
					  (make-variable-buffer-local 'ac-sources)
					  (add-to-list 'ac-sources 'ac-source-php-completion)
					  (auto-complete-mode t))))))


;;;; geben
;;; http://code.google.com/p/geben-on-emacs/
(add-hook 'php-mode-hook
          (lambda ()
            (my-autoload-and-when 'geben "geben")))


;;;; smarty-mode
;;;(install-elisp "http://lisp.morinie.fr/smarty/download/smarty-mode.el")
(add-hook 'php-mode-hook
          (lambda ()
            (my-autoload-and-when 'smarty-mode "smarty-mode")))
