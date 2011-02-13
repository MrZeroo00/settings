;;;; mmm-mode
;;;; http://sourceforge.net/projects/mmm-mode/
(my-require-and-when 'mmm-mode
  (setq mmm-global-mode 'maybe)
  (set-face-background 'mmm-default-submode-face "navy")

  ;; html + css
  (mmm-add-classes
   '((embedded-css
      :submode css-mode
      :front "<style[^>]*>"
      :back "</style>")))
  (mmm-add-mode-ext-class nil "\\.html?\\'" 'embedded-css))


;; -*-no-byte-compile: t; -*-
