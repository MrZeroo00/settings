;;;; flymake
(my-require-and-when 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)
