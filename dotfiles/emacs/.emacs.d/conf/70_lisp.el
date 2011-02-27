(my-require-and-when 'lisp-mode
  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(lisp-mode . (
                                anything-c-source-lisp-complete-symbol
                                anything-c-source-linkd-tag
                                )))
    )
  )


;;;; slime
;;;; http://common-lisp.net/project/slime/
(my-require-and-when 'slime-autoloads
  (setq slime-lisp-implementations
        `((sbcl ("/opt/local/bin/sbcl"))
          (clisp ("/opt/local/bin/clisp"))))

  (my-eval-after-load "slime"
    '(slime-setup '(slime-fancy slime-banner)))
  )


;;;; mode hook
(defun my-lisp-mode-hook ()
  ;; common setting
  (setq inferior-lisp-program "clisp")
  (define-key lisp-mode-map "\C-m" 'newline-and-indent)

  ;; slime
  (when (not (featurep 'slime))
    (my-require-and-when 'slime)
    (normal-mode)
    )
  )
(defun my-lisp-interaction-mode-hook ()
  ;; slime
  (when (not (featurep 'slime))
    (turn-on-eldoc-mode)
    )
  )
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-interaction-mode-hook)


;; -*-no-byte-compile: t; -*-
