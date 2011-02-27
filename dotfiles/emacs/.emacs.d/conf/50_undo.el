(setq undo-limit 100000)
(setq undo-strong-limit 130000)


;;;; redo
;;;(install-elisp "http://www.wonderworks.com/download/redo.el")
(my-require-and-when 'redo)


;;;; undo-tree
;;;(install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree.el")
(my-require-and-when 'undo-tree
  (global-undo-tree-mode))


;;;; point-undo
;;;(install-elisp-from-emacswiki "point-undo.el")
(my-require-and-when 'point-undo)
