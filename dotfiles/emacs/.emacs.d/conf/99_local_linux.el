(menu-bar-mode nil)


(when window-system
  (set-default-font "Bitstream Vera Sans Mono-10")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("VL ゴシック" . "unicode-bmp")))


;;;; anthy
;;;(my-require-and-when 'anthy)
;;;(setq default-input-method "japanese-anthy")
;;;(global-set-key "\C-o" 'anthy-mode)
;;;(anthy-change-hiragana-map "," "、")
;;;(anthy-load-hiragana-map anthy-alt-char-map)
;;;(setq anthy-wide-space " ")


;;;; anything
(setq anything-c-locate-options `("mlocate" "-q" "-i" "-n" "50" "-r"))


;; -*-no-byte-compile: t; -*-
