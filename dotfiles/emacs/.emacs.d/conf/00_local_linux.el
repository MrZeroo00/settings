(eval-after-load "anything-config"
  '(progn
     (setq anything-c-locate-options `("mlocate" "-q" "-i" "-n 50" "-r" "--"))
     ))

(when window-system
  (progn
    (set-default-font "Bitstream Vera Sans Mono-10")
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      '("VL ゴシック" . "unicode-bmp"))))
