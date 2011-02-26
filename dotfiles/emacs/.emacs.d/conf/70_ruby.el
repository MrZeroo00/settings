(my-autoload-and-when 'ruby-mode "ruby-mode"
  ;; flymake
  (when (featurep 'flymake)
    (defun flymake-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list "ruby" (list "-c" local-file))))
    (add-to-list 'flymake-allowed-file-name-masks
                 '(".+\\.rb$" flymake-ruby-init))

    )

  ;; align
  (when (featurep 'align)
    (progn
      (add-to-list 'align-rules-list
                   '(ruby-comma-delimiter
                     (regexp . ",\\(\\s-*\\)[^# \t\n]")
                     (repeat . t)
                     (modes  . '(ruby-mode))))
      (add-to-list 'align-rules-list
                   '(ruby-hash-literal
                     (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
                     (repeat . t)
                     (modes  . '(ruby-mode))))
      (add-to-list 'align-rules-list
                   '(ruby-assignment-literal
                     (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
                     (repeat . t)
                     (modes  . '(ruby-mode))))
      (add-to-list 'align-rules-list    ;TODO add to rcodetools.el
                   '(ruby-xmpfilter-mark
                     (regexp . "\\(\\s-*\\)# => [^#\t\n]")
                     (repeat . nil)
                     (modes  . '(ruby-mode))))
      )
    )

  ;; hs-minor-mode
  (when (featurep 'hideshow)
    (add-to-list 'hs-special-modes-alist
                 '(ruby-mode
                   "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
                   "end"
                   "#"
                   ruby-move-to-block
                   nil))
    )

  ;; autotest
  ;;(install-elisp-from-emacswiki "autotest.el")
  (my-require-and-when 'autotest)

  ;; refe
  ;;(install-elisp "http://ns103.net/~arai/ruby/refe.el")
  '(my-require-and-when 'refe)
  ;; http://d.hatena.ne.jp/rubikitch/20071228/rubyrefm
  ;;(install-elisp "http://www.rubyist.net/~rubikitch/archive/refe2.e")
  (my-load-and-when "_refe2")

  ;; macros
  (my-load-and-when "_ruby-insert-magic-comment-if-needed")
  )
(my-autoload-and-when 'run-ruby "inf-ruby"
  )
(my-autoload-and-when 'inf-ruby-keys "inf-ruby"
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))


;; macros
(when (fboundp 'ruby-insert-magic-comment-if-needed)
  (add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)
  )


;;;; mode hook
(defun my-ruby-mode-hook ()
  ;; common setting
  (setq ruby-deep-indent-paren-style nil)

  ;; auto-complete
  (when (featurep 'auto-complete)
    (make-variable-buffer-local 'ac-ignores)
    (add-to-list 'ac-ignores "end")
    )

  ;; flymake
  (when (featurep 'flymake)
    (inf-ruby-keys)
    (flymake-mode t)
    )
  )
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)


;; -*-no-byte-compile: t; -*-
