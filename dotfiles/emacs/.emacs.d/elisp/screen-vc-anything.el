(require 'screen-vc)
(provide 'screen-vc-anything)

(defvar anything-git-projects-screen-feature 'windows)

(defvar anything-c-source-screen-vc-select nil)

(when (featurep 'windows)
  (defvar anything-c-source-windows-select
    `((name . "*anything windows*")
      (init . (lambda () (win:switch-window win:current-config)))
      (candidates
       . (lambda ()
           (loop for i from 1 to (- win:max-configs 1)
                 for key = (+ win:base-key i)
                 for name-prefix = (aref win:names-prefix i)
                 for name = (aref win:names i)
                 when (and name (aref win:configs i))
                 collecting (cons (format "[%c]%s:%s" key name-prefix name) i))))
      (action
       ("select" .
        (lambda (n)
          (win:switch-window n))))))
  (setq anything-c-source-screen-vc-select anything-c-source-windows-select))

(when (featurep 'elscreen)
  (require 'anything-elscreen-fix)
  (setq anything-c-source-screen-vc-select anything-c-source-elscreen-fix))
