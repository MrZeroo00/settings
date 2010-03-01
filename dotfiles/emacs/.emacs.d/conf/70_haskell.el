(my-load-and-when "haskell-site-file")              ; autoload

;;;; mode-hook
(my-add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(my-add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;;(my-add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
