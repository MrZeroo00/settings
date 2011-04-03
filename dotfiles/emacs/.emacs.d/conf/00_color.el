(global-font-lock-mode t)


;;;; color-theme
;;;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))
(when (not window-system)
  (set-face-background 'highlight "blue"))


;;;; ediff
(ediff-odd-diff-face-A ((t (:background "black" :foreground "white"))))
(ediff-odd-diff-face-Ancestor ((t (:background "black" :foreground "white"))))
(ediff-odd-diff-face-B ((t (:background "black" :foreground "white"))))
(ediff-odd-diff-face-C ((t (:background "black" :foreground "white"))))
(ediff-even-diff-face-A ((t (:background "black" :foreground "white"))))
(ediff-even-diff-face-Ancestor ((t (:background "black" :foreground "white"))))
(ediff-even-diff-face-B ((t (:background "black" :foreground "white"))))
(ediff-even-diff-face-C ((t (:background "black" :foreground "white"))))


;;;; term
(setq term-default-fg-color "#FFFFFF")
(setq term-default-bg-color "#000000")
