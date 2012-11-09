(global-font-lock-mode t)
(if (>= emacs-major-version 21)
    (setq font-lock-support-mode 'jit-lock-mode)
  (setq font-lock-support-mode 'lazy-lock-mode))


;;;; 256 color
;;;; http://www.emacswiki.org/cgi-bin/wiki?PuTTY
(my-load-and-when "_256color")


;;;; color-theme
;;;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))
(set-face-background 'highlight "blue")
(unless window-system
  (setcdr (assoc 'background-color default-frame-alist) "unspecified-bg"))


;;;; ediff
(my-eval-after-load "ediff"
  (custom-set-faces
   '(ediff-odd-diff-face-A         ((((class color)) (:background "magenta"))))
   '(ediff-odd-diff-face-A         ((((class color)) (:foreground "white"))))
   '(ediff-even-diff-face-A        ((((class color)) (:background "magenta"))))
   '(ediff-even-diff-face-A        ((((class color)) (:foreground "white"))))
   '(ediff-odd-diff-face-B         ((((class color)) (:background "blue"))))
   '(ediff-odd-diff-face-B         ((((class color)) (:foreground "white"))))
   '(ediff-even-diff-face-B        ((((class color)) (:background "blue"))))
   '(ediff-even-diff-face-B        ((((class color)) (:foreground "white"))))
   '(ediff-odd-diff-face-C         ((((class color)) (:background "white"))))
   '(ediff-odd-diff-face-C         ((((class color)) (:foreground "black"))))
   '(ediff-even-diff-face-C        ((((class color)) (:background "white"))))
   '(ediff-even-diff-face-C        ((((class color)) (:foreground "black"))))
   '(ediff-odd-diff-face-Ancestor  ((((class color)) (:background "white"))))
   '(ediff-odd-diff-face-Ancestor  ((((class color)) (:foreground "black"))))
   '(ediff-even-diff-face-Ancestor ((((class color)) (:background "white"))))
   '(ediff-even-diff-face-Ancestor ((((class color)) (:foreground "black"))))
   )
  )


;;;; flymake
(my-eval-after-load "flymake"
  (custom-set-faces
   '(flymake-errline ((((class color)) (:background "Gray30"))))
   '(flymake-warnline ((((class color)) (:background "Gray20"))))
   )
  )


;;;; term
(setq term-default-fg-color "#FFFFFF")
(setq term-default-bg-color "#000000")


;;;; js2-mode
(my-eval-after-load "js2-mode"
  (custom-set-faces
   '(js2-error-face ((((class color)) (:underline "OrangeRed"))))
   '(js2-warning-face ((((class color)) (:underline "Yellow"))))
   )
  )


;;;; macros
(my-load-and-when "_what-face")
