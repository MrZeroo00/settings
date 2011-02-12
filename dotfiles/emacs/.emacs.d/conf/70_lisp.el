(my-require-and-when 'lisp-mode)

;;;; mode hook
(add-hook 'lisp-mode-hook
          (lambda ()
            (define-key lisp-mode-map "\C-m" 'newline-and-indent)))

(setq inferior-lisp-program "clisp")


;;;; anything
(add-hook 'lisp-mode-hook
          (lambda ()
            (make-local-variable 'anything-sources)
            (add-to-list 'anything-sources
                         anything-c-source-lisp-complete-symbol
                         anything-c-source-linkd-tag)))


;;;; slime
;;;; http://common-lisp.net/project/slime/
(setq load-path (cons "/opt/local/share/emacs/site-lisp/slime" load-path))
(my-require-and-when 'slime-autoloads
  (setq slime-lisp-implementations
        `((sbcl ("/opt/local/bin/sbcl"))
          (clisp ("/opt/local/bin/clisp"))))
  (add-hook 'lisp-mode-hook
            (lambda ()
              (cond ((not (featurep 'slime))
                     (my-require-and-when 'slime)
                     (normal-mode)))))

  (add-hook 'lisp-interaction-mode-hook
            'turn-on-eldoc-mode)

  (my-eval-after-load "slime"
    '(slime-setup '(slime-fancy slime-banner)))
  )
