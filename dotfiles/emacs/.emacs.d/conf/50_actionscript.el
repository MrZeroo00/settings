(autoload 'actionscript-mode "actionscript-mode" "Major mode for actionscript." t)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))
(eval-after-load "actionscript-mode" '(load "as-config"))
