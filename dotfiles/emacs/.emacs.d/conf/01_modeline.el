(line-number-mode t)
(column-number-mode t)

;;;; display time
(setq display-time-string-forms
      '(month "/" day " " dayname " " 
              24-hours ":" minutes " "
              (if mail " Mail" "") ))

(display-time-mode t)

;;;; show current directory
(add-to-list 'global-mode-string '("" default-directory "-"))
