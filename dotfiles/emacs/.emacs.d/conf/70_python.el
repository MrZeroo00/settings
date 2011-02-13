(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))


;;;; flymake
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "pyflakes" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init))


;; -*-no-byte-compile: t; -*-
