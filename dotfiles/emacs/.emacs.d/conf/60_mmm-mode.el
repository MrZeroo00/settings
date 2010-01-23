;; mmm-mode
;; http://sourceforge.net/projects/mmm-mode/
(require 'mmm-mode nil t)
(setq mmm-global-mode 'maybe)
(set-face-background 'mmm-default-submode-face "navy")

;; html + css
(mmm-add-classes
 '((embedded-css
    :submode css-mode
    :front "<style[^>]*>"
    :back "</style>")))
(mmm-add-mode-ext-class nil "\\.html?\\'" 'embedded-css)
