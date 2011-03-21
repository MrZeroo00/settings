(my-autoload-and-when 'css-mode "css-mode"
  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(css-mode . (
                               anything-c-source-imenu
                               )))
	)

  ;; speedbar
  (when (featurep 'speedbar)
	(speedbar-add-supported-extension '(".css"))
	)
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))


;;;; mode hook
(defun my-css-mode-hook ()
  ;; common setting
  (setq comment-style 'multi-line)

  ;; imenu
  (setq imenu-generic-expression '(("Selectors" "^[[:blank:]]*\\(.*[^ ]\\) *{" 1)))
  (setq imenu-case-fold-search nil)
  (setq imenu-auto-rescan t)
  (setq imenu-space-replacement " ")
  (imenu-add-menubar-index)
  )
(add-hook 'css-mode-hook 'my-css-mode-hook)
