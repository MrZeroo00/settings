(line-number-mode t)
(column-number-mode 1)
;; show current function
(which-function-mode 1)

;; display time
(setq display-time-string-forms
      '(month "/" day " " dayname " " 
              24-hours ":" minutes " "
              (if mail " Mail" "") ))

(display-time-mode 1)

;; show current directory
(add-to-list 'global-mode-string '("" default-directory "-"))
