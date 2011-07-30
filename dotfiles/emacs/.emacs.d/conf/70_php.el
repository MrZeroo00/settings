;;;; http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
(my-autoload-and-when 'php-mode "php-mode"
  ;; flymake
  (when (featurep 'flymake)
    (defun flymake-php-init ()
      "Use php to check the syntax of the current file."
      (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
             (local (file-relative-name temp (file-name-directory buffer-file-name))))
        ;;(list "php" (list "-f" local "-l"))))
        (list "php" (list "-n" "-f" local "-l"))))

    (add-to-list 'flymake-err-line-patterns
                 '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

    (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
    )

  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(php-mode . (
                               ;;anything-c-source-yasnippet
                               anything-c-source-imenu
                               ;;anything-c-source-gtags-select
                               )))
	(add-to-list 'anything-kyr-commands-by-major-mode
				 '(php-mode
				   my-geben
				   ))
    )

  ;; imenu
  ;;(install-elisp "http://www.oak.homeunix.org/%7Emarcel/blog/files/php-imenu.el")
  (my-autoload-and-when 'php-imenu-create-index "php-imenu"
    (add-hook 'php-mode-user-hook 'php-imenu-setup)
    ;;(setq php-imenu-alist-postprocessor (function reverse))
	)

  ;; speedbar
  (when (featurep 'speedbar)
	(speedbar-add-supported-extension '(".php"))
	)

  ;; align
  (when (featurep 'align)
    (add-to-list 'align-rules-list
                 '(php-hash-literal
                   (regexp . "\\(\\s-*\\)=>\\s-*[^/ \t\n]")
                   (repeat . t)
                   (modes  . '(php-mode))))
    )

  ;; hs-minor-mode
  (when (featurep 'hideshow)
    (add-to-list 'hs-special-modes-alist
                 '(php-mode
                   "{"
                   "}"
                   "/[*/]"
                   nil
                   hs-c-like-adjust-block-beginning))
    )

  ;; geben
  ;; http://code.google.com/p/geben-on-emacs/
  (my-autoload-and-when 'geben "geben"
    (setq geben-temporary-file-directory (expand-file-name "geben" "~/.emacs.d/data"))
    (defun my-geben-find-file (file-path)
      (geben-with-current-session session
                                  (geben-open-file (geben-source-fileuri session file-path))))
    (defadvice find-file (around my-geben-find-file-advice disable)
      "replace standard find-file by geben-find-file."
      (let ((file (ad-get-arg 0)))
        (unless (string-match "\\.php$" file)
          (ad-do-it))
        (if (memq 'geben-mode minor-mode-list)
            (my-geben-find-file file)
          ad-do-it)))
	(defun my-geben-find-file-advice-enable (session)
	  (ad-enable-advice 'find-file 'around 'my-geben-find-file-advice)
	  (ad-activate 'find-file))
	(defun my-geben-find-file-advice-disable (session)
	  (ad-disable-advice 'find-file 'around 'my-geben-find-file-advice)
	  (ad-activate 'find-file))
	(add-hook 'geben-session-enter-hook 'my-geben-find-file-advice-enable)
	(add-hook 'geben-session-enter-hook 'my-geben-find-file-advice-disable)
    )
  (defun my-geben ()
	(geben 1)
	(message "GEBEN is started."))

  ;; PHP API Reference
  (defun my-phpdoc ()
    (interactive)
    (let* ((symbol (thing-at-point 'symbol))
           (query (concat "phpdoc " symbol)))
      (popup-tip (shell-command-to-string query))))
  ;;(define-key global-map "\M-q" 'my-phpdoc)

  ;; php.log
  (add-to-list 'compilation-error-regexp-alist '("in \\(.*?\\) on line \\([0-9]+\\)$" 1 2))
  ;;(add-to-list 'compilation-error-regexp-alist '(" \\([^ ]*?\\):\\([0-9]+\\)$" 1 2))
  )


;;;; smarty-mode
;;;; http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
;;;(install-elisp "http://lisp.morinie.fr/smarty/download/smarty-mode.el")
(my-autoload-and-when 'smarty-mode "smarty-mode"
  (add-to-list 'wrap-region-tag-active-modes 'smarty-mode)
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))
(add-to-list 'auto-mode-alist '("\\.tpl" . smarty-mode))


;;;; common setting
(add-to-list 'which-func-modes 'php-mode)


;;;; mode hook
(defun my-php-mode-hook ()
  ;; common setting
  (setq c-basic-offset tab-width)
  '(setq php-mode-force-pear t)

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
  (when (featurep 'gtags)
    (gtags-mode t)
    ;;(gtags-make-complete-list)
    )

  ;; imenu
  (setq imenu-create-index-function (function php-imenu-create-index))
  (imenu-add-menubar-index)

  ;; flymake
  (when (featurep 'flymake)
    (flymake-mode t)
    )

  ;; hs-minor-mode
  (when (featurep 'hideshow)
    (hs-minor-mode 1)
    )

  ;; php.log
  (setq compile-command "tac /var/log/php.log | grep 'on line' | tail -n 100")
  )
(add-hook 'php-mode-hook 'my-php-mode-hook)
