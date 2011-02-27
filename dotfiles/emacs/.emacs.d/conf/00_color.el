;;;; color setting
(global-font-lock-mode t)
'(if window-system (progn
                     (set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
                     (set-face-foreground 'font-lock-string-face "purple")
                     (set-face-foreground 'font-lock-keyword-face "blue")
                     (set-face-foreground 'font-lock-function-name-face "blue")
                     (set-face-bold-p 'font-lock-function-name-face t)
                     (set-face-foreground 'font-lock-variable-name-face "black")
                     (set-face-foreground 'font-lock-type-face "LightSeaGreen")
                     (set-face-foreground 'font-lock-builtin-face "purple")
                     (set-face-foreground 'font-lock-constant-face "black")
                     (set-face-foreground 'font-lock-warning-face "blue")
                     (set-face-bold-p 'font-lock-warning-face nil)
                     (set-face-foreground 'modeline "gray10")
                     (set-face-background 'modeline "bisque3")
                     (set-face-foreground 'mode-line-inactive "gray30")
                     (set-face-background 'mode-line-inactive "gray85")
                     (set-face-background 'region "DeepPink1")
                     ))

;;;; color-theme
;;;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))
(when (not window-system)
  (set-face-background 'highlight "blue"))
