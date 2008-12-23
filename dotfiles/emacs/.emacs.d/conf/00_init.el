;; base settings
(cd "~/")
(global-font-lock-mode t)
;; sample setting
(setq default-frame-alist
      (append (list '(top . 30)	; 起動時の表示位置(右から)
                    '(left . 200) ; 起動時の表示位置(左から)
                    '(width . 80) ; 起動時のサイズ(幅)
                    '(height . 45) ; 起動時のサイズ(縦)
;                    '(foreground-color . "#000000") ; 文字の色
;                    '(background-color . "old lace") ; 背景の色
;                    '(font . "fontset-tt14") ; 使うフォントセット
                    )
              default-frame-alist))

(transient-mark-mode t)
(show-paren-mode t)

;; Highlight current line
(global-hl-line-mode)
;(setq hl-line-face 'underline)
(hl-line-mode 1)

;; indent
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;; Language
;;(require 'un-define)
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(setq default-buffer-file-coding-system 'utf-8)

;; key bind settings
(global-set-key "\C-h" 'delete-backward-char)

;; HTTP Proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)
