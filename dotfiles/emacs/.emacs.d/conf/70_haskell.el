(my-load-and-when "haskell-site-file"
  )  ; autoload


;;;; mode hook
(defun my-haskell-mode-hook ()
  ;; common setting
  (turn-on-haskell-indent)
  (turn-on-haskell-doc-mode)
  '(turn-on-haskell-simple-indent)
  )
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)


;; -*-no-byte-compile: t; -*-
