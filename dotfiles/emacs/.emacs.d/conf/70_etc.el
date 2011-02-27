;;;; graphviz
(my-load-and-when "graphviz-dot-mode")


;;;; pov-mode
;;;; http://www.acc.umu.se/~woormie/povray/
;;;(my-autoload-and-when 'pov-mode "pov-mode.el")
'(setq auto-mode-alist
      (append '(("\\.pov$" . pov-mode)
                ("\\.inc$" . pov-mode)
                ) auto-mode-alist))


;;;; generic (coloring generic files)
'(my-require-and-when 'generic-x
  ;; association setting
  (add-to-list 'auto-mode-alist '("\\.bat$" . bat-generic-mode))
  (add-to-list 'auto-mode-alist '("\\.ini$" . ini-generic-mode)))
