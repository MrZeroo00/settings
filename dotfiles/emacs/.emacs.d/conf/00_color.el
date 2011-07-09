(global-font-lock-mode t)
(if (>= emacs-major-version 21)
    (setq font-lock-support-mode 'jit-lock-mode)
  (setq font-lock-support-mode 'lazy-lock-mode))


;;;; color-theme
;;;; https://gna.org/projects/color-theme
(when (window-system)
  (my-require-and-when 'color-theme
    (color-theme-initialize)
    (color-theme-clarity))
  (set-face-background 'highlight "blue"))


;;;; ediff
(my-eval-after-load "ediff"
  (set-face-background ediff-odd-diff-face-A "magenta")
  (set-face-foreground ediff-odd-diff-face-A "white")
  (set-face-background ediff-even-diff-face-A "magenta")
  (set-face-foreground ediff-even-diff-face-A "white")
  (set-face-background ediff-odd-diff-face-B "blue")
  (set-face-foreground ediff-odd-diff-face-B "white")
  (set-face-background ediff-even-diff-face-B "blue")
  (set-face-foreground ediff-even-diff-face-B "white")
  (set-face-background ediff-odd-diff-face-C "white")
  (set-face-foreground ediff-odd-diff-face-C "black")
  (set-face-background ediff-even-diff-face-C "white")
  (set-face-foreground ediff-even-diff-face-C "black")
  (set-face-background ediff-odd-diff-face-Ancestor "white")
  (set-face-foreground ediff-odd-diff-face-Ancestor "black")
  (set-face-background ediff-even-diff-face-Ancestor "white")
  (set-face-foreground ediff-even-diff-face-Ancestor "black")
  )


;;;; term
(setq term-default-fg-color "#FFFFFF")
(setq term-default-bg-color "#000000")
