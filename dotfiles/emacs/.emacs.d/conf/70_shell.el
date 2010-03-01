;;;; flymake
(my-require-and-when 'flymake-shell
  (my-add-hook 'sh-mode-hook 'flymake-shell-load))
