;; base settings
(cd "~/")
(global-font-lock-mode t)
;; sample setting
(setq default-frame-alist
      (append (list '(top . 30)         ; 起動時の表示位置(右から)
                    '(left . 200)       ; 起動時の表示位置(左から)
                    '(width . 80)       ; 起動時のサイズ(幅)
                    '(height . 45)      ; 起動時のサイズ(縦)
                    '(foreground-color . "green")       ; 文字の色
                    '(background-color . "black")       ; 背景の色
                    '(cursor-color . "DarkOliveGreen1") ; カーソルの色
                    '(mouse-color . "DarkOliveGreen1") ; マウスポインタの色
                    ;'(font . "fontset-tt14") ; 使うフォントセット
                    )
              default-frame-alist))

;; source code color setting
;(if window-system (progn
;                    (set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
;                    (set-face-foreground 'font-lock-string-face "purple")
;                    (set-face-foreground 'font-lock-keyword-face "blue")
;                    (set-face-foreground 'font-lock-function-name-face "blue")
;                    (set-face-bold-p 'font-lock-function-name-face t)
;                    (set-face-foreground 'font-lock-variable-name-face "black")
;                    (set-face-foreground 'font-lock-type-face "LightSeaGreen")
;                    (set-face-foreground 'font-lock-builtin-face "purple")
;                    (set-face-foreground 'font-lock-constant-face "black")
;                    (set-face-foreground 'font-lock-warning-face "blue")
;                    (set-face-bold-p 'font-lock-warning-face nil)
;))

;; other color setting
(set-face-foreground 'modeline "gray10")
(set-face-background 'modeline "bisque3")
(set-face-foreground 'mode-line-inactive "gray30")
(set-face-background 'mode-line-inactive "gray85")
(set-face-background 'region "DeepPink1")

(transient-mark-mode t)
(show-paren-mode t)

;; Highlight current line
(global-hl-line-mode)
(hl-line-mode 1)
;(setq hl-line-face 'underline)
(set-face-background 'hl-line "DarkOliveGreen")

;; indent
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
(require 'indent-tabs-maybe)

;; Language
;;(require 'un-define)
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(setq default-buffer-file-coding-system 'utf-8)

;; Etc
(auto-insert-mode t)
(auto-compression-mode t)
(auto-image-file-mode t)
(recentf-mode)
(setq delete-auto-save-files t)
(setq kill-whole-line t)
(setq next-line-add-newlines nil)
(setq visible-bell t)
(setq ange-ftp-try-passive-mode t)
(set-scroll-bar-mode 'right)

;; key bind settings
(global-set-key "\C-h" 'delete-backward-char)

;; HTTP Proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)
