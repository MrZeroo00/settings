;; http://yaml-mode.clouder.jp/
(autoload 'yaml-mode "yaml-mode" "YAML" t)

; association setting
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

; mode hook
(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
