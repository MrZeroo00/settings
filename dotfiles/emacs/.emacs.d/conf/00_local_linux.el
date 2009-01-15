(when window-system
  (progn
    (set-default-font "Bitstream Vera Sans Mono-10")
    (set-fontset-font (frame-parameter nil 'font)
                      'japanese-jisx0208
                      '("VL ゴシック" . "unicode-bmp"))))
