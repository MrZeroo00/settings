;; base settings
(cd "~/")
(global-font-lock-mode t)
;; sample setting
(setq default-frame-alist
      (append (list '(top . 20)         ; 起動時の表示位置(右から)
                    '(left . 100)       ; 起動時の表示位置(左から)
                    '(width . 80)       ; 起動時のサイズ(幅)
                    '(height . 45)      ; 起動時のサイズ(縦)
                    ;'(foreground-color . "green")       ; 文字の色
                    ;'(background-color . "black")       ; 背景の色
                    ;'(alpha . (nil 70 50 30))           ; 透過
                    ;'(cursor-color . "DarkOliveGreen1") ; カーソルの色
                    ;'(mouse-color . "DarkOliveGreen1") ; マウスポインタの色
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

;; color-theme
;; https://gna.org/projects/color-theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)


;; highlight
(setq search-highlight t)
(setq query-replace-highlight t)
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

;; clipboard
;; http://d.hatena.ne.jp/pakepion/20081209/1228828521
(when (or run-linux run-bsd run-unix run-system-v)
  (progn
    (setq interprogram-paste-function
          (lambda ()
            (shell-command-to-string "xsel -b -o")))
    (setq interprogram-cut-function
          (lambda (text &optional rest)
            (let* ((process-connection-type nil)
                   (proc (start-process "xsel" "*Messages*" "xsel" "-b" "-i")))
              (process-send-string proc text)
              (process-send-eof proc))))))

;; scroll
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)
(setq scroll-preserve-screen-position t)

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


;; Locale
(setenv "LC_TIME" "C")


;; install-elisp
;(install-elisp-from-emacswiki "install-elisp.el")
;(require 'install-elisp)
;(setq install-elisp-repository-directory "~/.emacs.d/elisp/")


;; auto-install
;(install-elisp-from-emacswiki "auto-install.el")
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)


;; instamp
;(install-elisp "http://www.gentei.org/~yuuji/software/euc/instamp.el")
(autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;(define-key global-map "\C-cs" 'instamp)


;; Etc
(setq inhibit-startup-message t)
(setq frame-title-format "%b")
(tool-bar-mode nil)
;(menu-bar-mode nil)
(set-scroll-bar-mode 'right)
(setq visible-bell t)
;(fset 'yes-or-no-p 'y-or-n-p)
(setq debug-on-error nil)
(auto-insert-mode t)
;(global-auto-revert-mode)
(setq kill-whole-line t)
(setq kill-read-only-ok t)
(setq next-line-add-newlines nil)
(setq truncate-lines t)
(setq truncate-partial-width-windows t)
(setq history-length t)
(setq undo-limit 100000)
(setq undo-strong-limit 130000)
(setq diff-switches "-u")
;(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*Occur*"))
(setq x-select-enable-clipboard t)


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


;; macros
;(load "_visible-mark-mode")
;(load "_egoge-wash-out-colour")
(load "_elisp-font-lock-top-quote")
(load "_line-to-top-of-window")
