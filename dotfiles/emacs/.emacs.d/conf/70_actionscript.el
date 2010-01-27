(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)

; association setting
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

; mode hook
(add-hook 'actionscript-mode-hook
          (lambda ()
            (my-load-and-when "as-config")))
