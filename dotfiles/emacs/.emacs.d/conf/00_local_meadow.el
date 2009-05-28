(set-language-environment "Japanese")

;; IME
(setq default-input-method "MW32-IME")
(add-hook 'mw32-ime-on-hook
          (function (lambda () (set-cursor-color "SkyBlue"))))
(add-hook 'mw32-ime-off-hook
          (function (lambda () (set-cursor-color "LemonChiffon"))))
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[J]" "[--]"))
(mw32-ime-initialize)

;; mouse cursor
(setq w32-hide-mouse-timeout 1000)
(setq w32-hide-mouse-on-key t)
