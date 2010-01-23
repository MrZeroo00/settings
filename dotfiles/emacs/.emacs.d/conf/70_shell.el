;; flymake
(require 'flymake-shell nil t)
(add-hook 'sh-mode-hook 'flymake-shell-load)
