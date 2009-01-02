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

;; Highlight current line
(global-hl-line-mode)
(hl-line-mode 1)
;(setq hl-line-face 'underline)
(set-face-background 'hl-line "DarkOliveGreen")

;; region
(transient-mark-mode t)
;(setq highlight-nonselected-windows t)
;(pc-selection-mode)
;(delete-selection-mode 1)

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

;; Update timestamp when saving
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=myfunc%20time-stamp
(defvar my-save-buffer-hook nil)
(defun save-buffer-wrapper ()
  (interactive)
  (let ((tostr (concat "$Lastupdate: " (format-time-string "%Y/%m/%d %k:%M:%S") " $")))
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward
              "\\$Lastupdate\\([0-9/: ]*\\)?\\$" nil t)
        (replace-match tostr nil t)))
    (run-hooks 'my-save-buffer-hook)
    (save-buffer)))
(global-set-key "\C-x\C-s" 'save-buffer-wrapper)

;; instamp
;(install-elisp "http://www.gentei.org/~yuuji/software/euc/instamp.el")
(autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;(define-key global-map "\C-cs" 'instamp)


;; Etc
(auto-insert-mode t)
(auto-compression-mode t)
(auto-image-file-mode t)
(recentf-mode)
(setq delete-auto-save-files t)
(setq kill-whole-line t)
(setq kill-read-only-ok t)
(setq next-line-add-newlines nil)
(setq visible-bell t)
(setq ange-ftp-try-passive-mode t)
(set-scroll-bar-mode 'right)
;(fset 'yes-or-no-p 'y-or-n-p)

;; redo
;(install-elisp "http://www.wonderworks.com/download/redo.el")
(require 'redo)

;; kill-summary
;(install-elisp "http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el")
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)

;; list-register
;(install-elisp "http://www.bookshelf.jp/elc/list-register.el")
(require 'list-register)

;; key bind settings
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key [mouse-3] 'yank)

;; HTTP Proxy
(setq http-proxy-server "localhost")
(setq http-proxy-port 8080)
