(my-load-and-when "po-mode"
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.po\\'\\|\\.po\\." . po-mode))
