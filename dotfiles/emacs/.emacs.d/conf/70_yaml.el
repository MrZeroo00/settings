;;;; http://yaml-mode.clouder.jp/
(my-autoload-and-when 'yaml-mode "yaml-mode")

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;;; mode hook
(my-eval-after-load "yaml-mode"
  (add-hook 'yaml-mode-hook
            (lambda ()
              (define-key yaml-mode-map "\C-m" 'newline-and-indent))))


;; -*-no-byte-compile: t; -*-
