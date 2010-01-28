(my-autoload-and-when 'actionscript-mode "actionscript-mode")

; association setting
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

; mode hook
(my-eval-after-load "actionscript-mode"
  (add-hook 'actionscript-mode-hook
            (lambda ()
              (my-load-and-when "as-config"))))
