(my-autoload-and-when 'php-mode "php-mode"
  (when (featurep 'flymake)
    (defun flymake-php-init ()
      "Use php to check the syntax of the current file."
      (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
             (local (file-relative-name temp (file-name-directory buffer-file-name))))
        (list "php" (list "-f" local "-l"))))

    (add-to-list 'flymake-err-line-patterns
                 '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

    (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
    )
  )


;;;; smarty-mode
;;;(install-elisp "http://lisp.morinie.fr/smarty/download/smarty-mode.el")
(my-autoload-and-when 'smarty-mode "smarty-mode")


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))
(add-to-list 'auto-mode-alist '("\\.tpl" . smarty-mode))


;;;; common setting
(add-to-list 'which-func-modes 'php-mode)


;;;; mode hook
(defun my-php-mode-hook ()
  ;; common setting
  '(setq php-mode-force-pear t)

  ;; anything
  '(when (featurep 'anything)
     (make-variable-buffer-local 'anything-sources)
     '(add-to-list 'anything-sources 'anything-c-source-yasnippet t)
     (add-to-list 'anything-sources 'anything-c-source-imenu t)
     '(add-to-list 'anything-sources 'anything-c-source-gtags-select t)
     )

  ;; php-completion
  ;;(install-elisp-from-emacswiki "php-completion.el")
  (my-require-and-when 'php-completion
    (php-completion-mode t)
    '(define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
    (when (featurep 'auto-complete)
      (add-to-list 'ac-sources 'ac-source-php-completion)
      (auto-complete-mode t)
      )
    )

  ;; auto-complete
  (when (featurep 'auto-complete)
    (add-to-list 'ac-sources 'ac-source-yasnippet) ; ac-sources order is important
    )

  ;; gtags
  (gtags-mode t)
  '(gtags-make-complete-list)

  ;; geben
  ;; http://code.google.com/p/geben-on-emacs/
  (my-autoload-and-when 'geben "geben")
  )
(add-hook 'php-mode-hook 'my-php-mode-hook)


;; -*-no-byte-compile: t; -*-
