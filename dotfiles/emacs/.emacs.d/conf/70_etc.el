;;;; graphviz
(my-load-and-when "graphviz-dot-mode")


;;;; pov-mode
;;;; http://www.acc.umu.se/~woormie/povray/
;;;(my-autoload-and-when 'pov-mode "pov-mode.el")
'(progn
   (add-to-list 'auto-mode-alist '("\\.pov$" . pov-mode))
   (add-to-list 'auto-mode-alist '("\\.inc$" . pov-mode))
   )


;;;; generic (coloring generic files)
'(my-require-and-when 'generic-x
  ;; association setting
  (add-to-list 'auto-mode-alist '("\\.bat$" . bat-generic-mode))
  (add-to-list 'auto-mode-alist '("\\.ini$" . ini-generic-mode)))
