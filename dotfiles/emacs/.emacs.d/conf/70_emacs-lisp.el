(my-require-and-when 'lisp-mode)

; association setting
(add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))

; mode hook
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (define-key emacs-lisp-mode-map "\C-m" 'newline-and-indent)))


;; anything
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (make-local-variable 'anything-sources)
            ;(add-to-list 'anything-sources
;           ;              anything-c-source-lisp-complete-symbol
;           ;              anything-c-source-linkd-tag
            ;             )
            ))


;; flymake
(defun flymake-elisp-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "elisplint" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.el$" flymake-elisp-init))

; tentative patch
(when (not run-w32)
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (flymake-mode t))))


;; eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)


;; checkdoc
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (my-require-and-when 'checkdoc)))


;; lispxmp
;(install-elisp-from-emacswiki "lispxmp.el")
;(my-require-and-when 'lispxmp)
