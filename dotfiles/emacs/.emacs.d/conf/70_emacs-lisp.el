(my-require-and-when 'lisp-mode
  ;; anything
  (when (featurep 'anything)
    (add-to-list 'anything-mode-specific-alist
                 '(emacs-lisp-mode . (
                                      anything-c-source-lisp-complete-symbol
                                      ;anything-c-source-linkd-tag
                                      )))
	(add-to-list 'anything-kyr-commands-by-major-mode
				 '(emacs-lisp-mode
				   byte-compile-file
				   ))
    )

  ;; flymake
  (when (featurep 'flymake)
    (defun flymake-elisp-init ()
      (if (string-match "^ " (buffer-name))
          nil
        (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                             'flymake-create-temp-inplace))
               (local-file  (file-relative-name
                             temp-file
                             (file-name-directory buffer-file-name))))
          (list
           (expand-file-name invocation-name invocation-directory)
           (list
            "-Q" "--batch" "--eval"
            (prin1-to-string
             (quote
              (dolist (file command-line-args-left)
                (with-temp-buffer
                  (insert-file-contents file)
                  (condition-case data
                      (scan-sexps (point-min) (point-max))
                    (scan-error
                     (goto-char(nth 2 data))
                     (princ (format "%s:%s: error: Unmatched bracket or quote\n"
                                    file (line-number-at-pos)))))))
              )
             )
            local-file)))))
    (add-to-list 'flymake-allowed-file-name-masks
                 '("\\.el$" flymake-elisp-init))
    )

  ;; lispxmp
  ;;(install-elisp-from-emacswiki "lispxmp.el")
  '(my-require-and-when 'lispxmp)

  ;; checkdoc
  (my-require-and-when 'checkdoc)
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))


;;;; mode hook
(defun my-emacs-lisp-mode-hook ()
  ;; common setting
  (define-key emacs-lisp-mode-map "\C-m" 'newline-and-indent)

  ;; flymake
  (when (not run-w32)                   ; tentative patch
    (unless (null buffer-file-name)
      (flymake-mode t)))

  ;; hs-minor-mode
  (when (featurep 'hideshow)
    (hs-minor-mode 1)
    )

  ;; eldoc
  (turn-on-eldoc-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)


;; -*-no-byte-compile: t; -*-
