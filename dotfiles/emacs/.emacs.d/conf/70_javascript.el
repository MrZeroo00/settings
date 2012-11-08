;;;; js2-mode
;;;; http://code.google.com/p/js2-mode/
(my-autoload-and-when 'js2-mode "js2"
  ;; flymake
  (when (featurep 'flymake)
    (defconst flymake-allowed-js-file-name-masks'(("\\.json$" flymake-js-init)
                                                  ("\\.js$" flymake-js-init)))
    (defcustom flymake-js-detect-trailing-comma t nil :type 'boolean)
    (add-to-list 'flymake-err-line-patterns '("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" 1 2 nil 3))
    (when flymake-js-detect-trailing-comma
      (add-to-list 'flymake-err-line-patterns
                   '("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)))
    (add-to-list 'flymake-err-line-patterns
                 '("^\\([^:]+\\): line \\([0-9]+\\), col \\([0-9]+\\), \\(.+\\)$" 1 2 nil 4))

    (defun flymake-js-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "jscheck" (list local-file))))

    (defun flymake-js-load ()
      (interactive)
      (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
        (setq flymake-check-was-interrupted t))
      (ad-activate 'flymake-post-syntax-check)
      (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-js-file-name-masks))
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
