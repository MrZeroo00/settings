(my-load-and-when "haskell-site-file")              ; autoload

;; mode-hook
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
