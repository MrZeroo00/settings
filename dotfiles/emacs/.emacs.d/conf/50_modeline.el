(line-number-mode t)
(column-number-mode t)
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;;;; display time
(setq display-time-string-forms
      '(month "/" day " " dayname " "
              24-hours ":" minutes " "
              (if mail " Mail" "") ))
(display-time-mode t)

;;;; show current directory
(add-to-list 'global-mode-string '("" default-directory "-"))

;;;; format
(setq mode-line-format '("%e"
                         #("-" 0 1
                           (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                         mode-line-mule-info
                         mode-line-client
                         mode-line-modified
                         mode-line-remote
                         mode-line-frame-identification
                         mode-line-buffer-identification
                         #("   " 0 3
                           (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                         mode-line-position
                         (vc-mode vc-mode)
                         #("  " 0 2
                           (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                         mode-line-modes
                         (which-func-mode
                          ("" which-func-format
                           #("--" 0 2
                             (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))
                         (global-mode-string
                          (#("--" 0 2
                             (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                           global-mode-string))
                         #("-%-" 0 3
                           (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display")))
      )
(setq mode-line-frame-identification " ")
