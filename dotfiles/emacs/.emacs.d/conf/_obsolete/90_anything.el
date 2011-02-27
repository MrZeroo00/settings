;;;; anything-call-source


;;;; anything-compile-source--candidates-file
'(defvar anything-c-source-home-directory
  '((name . "Home directory")
    ;; /log/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
    (candidates-file "/log/home.filelist" updating)
    (requires-pattern . 5)
    (candidate-number-limit . 20)
    (type . file)))


;;;; anything-display-function
'(my-require-and-when 'split-root
  (defvar anything-compilation-window-height-percent 50.0)
  (defun anything-compilation-window-root (buf)
    (setq anything-compilation-window
          (split-root-window (truncate (* (window-height)
                                          (/ anything-compilation-window-height-percent
                                             100.0)))))
    (set-window-buffer anything-compilation-window buf))
  (setq anything-display-function 'anything-compilation-window-root)
  )
