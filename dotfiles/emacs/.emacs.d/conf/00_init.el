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

;; highlight
(require 'hi-lock)
; highlight current line
(global-hl-line-mode)
(hl-line-mode t)
;(setq hl-line-face 'underline)
(set-face-background 'hl-line "DarkOliveGreen")

;; region
(transient-mark-mode t)
;(setq highlight-nonselected-windows t)
;(pc-selection-mode)
;(delete-selection-mode t)

;; scroll
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)

;; Language
;;(require 'un-define)
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(setq default-buffer-file-coding-system 'utf-8)

;; Timestamp
(setq time-stamp-start "Time-stamp:[ \t]*<")
(setq time-stamp-end ">")


;; instamp
;(install-elisp "http://www.gentei.org/~yuuji/software/euc/instamp.el")
(autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;(define-key global-map "\C-cs" 'instamp)


;; Etc
(setq inhibit-startup-message t)
(auto-insert-mode t)
(setq kill-whole-line t)
(setq kill-read-only-ok t)
(setq next-line-add-newlines nil)
(setq visible-bell t)
(set-scroll-bar-mode 'right)
;(fset 'yes-or-no-p 'y-or-n-p)
; for coding
(setq grep-find-command "find . -type f ! -name '*,v' ! -name '*~' ! -name '*.o' ! -name '*.a' ! -name '*.so' ! -name '*.class' ! -name '*.jar' ! -name 'semantic.cache' ! -path '*.deps*' ! -path '*/obsolete/*' ! -path '*/.svn/*' ! -path '*/CVS/*' -print0 | xargs -0 -e grep -n -e ")


;; redo
;(install-elisp "http://www.wonderworks.com/download/redo.el")
(require 'redo)

;; point-undo
;(install-elisp-from-emacswiki "point-undo.el")
(require 'point-undo)

;; kill-summary
;(install-elisp "http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el")
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)

;; list-register
;(install-elisp "http://www.bookshelf.jp/elc/list-register.el")
(require 'list-register)

;; pit
(require 'pit)

;; key bind settings
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key [mouse-3] 'yank)
