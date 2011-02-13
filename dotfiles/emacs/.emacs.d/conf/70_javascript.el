;;;; js2-mode
;;;; http://code.google.com/p/js2-mode/
(my-autoload-and-when 'js2-mode "js2"
  ;; flymake
  (my-require-and-when 'flymake
    (defconst flymake-allowed-js-file-name-masks'(("\\.json$" flymake-js-init)
                                                  ("\\.js$" flymake-js-init)))
    (defcustom flymake-js-detect-trailing-comma t nil :type 'boolean)
    (defvar flymake-js-err-line-patterns '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" 1 2 nil 3)))
    (when flymake-js-detect-trailing-comma
      (setq flymake-js-err-line-patterns (append flymake-js-err-line-patterns
                                                 '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)))))

    (defun flymake-js-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "js" (list "-s" local-file))))

    (defun flymake-js-load ()
      (interactive)
      (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
        (setq flymake-check-was-interrupted t))
      (ad-activate 'flymake-post-syntax-check)
      (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-js-file-name-masks))
      (setq flymake-err-line-patterns flymake-js-err-line-patterns)
      (flymake-mode t))
    )
)


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


;;;; mode hook
(defun my-javascript-mode-hook ()
  ;; flymake
  (when (featurep 'flymake)
    (flymake-js-load))
  )
(add-hook 'javascript-mode-hook 'my-javascript-mode-hook)


;; -*-no-byte-compile: t; -*-
