(transient-mark-mode t)
'(setq highlight-nonselected-windows t)
'(pc-selection-mode)
'(delete-selection-mode t)
(setq shift-select-mode nil)


;;;; visible-mark
;;;(install-elisp-from-emacswiki "visible-mark.el")
(my-require-and-when 'visible-mark)


;;;; cua-mode
(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
'(setq cua-keep-region-after-copy t)
(setq cua-enable-cua-keys nil)


;;;; wrap-region
;;;(install-elisp "https://github.com/rejeep/wrap-region/raw/master/wrap-region.el")
(my-require-and-when 'wrap-region
  (wrap-region-global-mode t)
  ;;(add-to-list 'wrap-region-tag-active-modes 'some-tag-mode)
  ;;(add-to-list 'wrap-region-except-modes 'conflicting-mode)
  )


;;;; align (align code)
(my-require-and-when 'align)
