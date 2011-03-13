;;;; viewer
;;;(install-elisp-from-emacswiki "viewer")
(my-require-and-when 'viewer
  (viewer-stay-in-setup)
  (setq viewer-modeline-color-unwritable "tomato"
        viewer-modeline-color-view "orange")
  (viewer-change-modeline-color-setup)
  ;;(viewer-aggressive-setup 'force)
  ;;(setq view-mode-by-default-regexp "/regexp-to-path")
  )
