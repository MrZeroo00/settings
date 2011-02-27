(global-font-lock-mode t)


;;;; color-theme
;;;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))
(when (not window-system)
  (set-face-background 'highlight "blue"))


;;;; term
(setq term-default-fg-color "#FFFFFF")
(setq term-default-bg-color "#000000")
