;; base settings
(cd "~/")
(global-font-lock-mode t)
;; sample setting
(setq default-frame-alist
      (append (list '(top . 30)	; $B5/F0;~$NI=<(0LCV(B($B1&$+$i(B)
                    '(left . 200) ; $B5/F0;~$NI=<(0LCV(B($B:8$+$i(B)
                    '(width . 80) ; $B5/F0;~$N%5%$%:(B($BI}(B)
                    '(height . 45) ; $B5/F0;~$N%5%$%:(B($B=D(B)
;                    '(foreground-color . "#000000") ; $BJ8;z$N?'(B
;                    '(background-color . "old lace") ; $BGX7J$N?'(B
;                    '(font . "fontset-tt14") ; $B;H$&%U%)%s%H%;%C%H(B
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
