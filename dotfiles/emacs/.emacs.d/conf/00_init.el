;; install-elisp
;(install-elisp-from-emacswiki "install-elisp.el")
;(my-require-and-when 'install-elisp
;  (setq install-elisp-repository-directory "~/.emacs.d/elisp/"))


;; auto-install
;(install-elisp-from-emacswiki "auto-install.el")
;(my-require-and-when 'auto-install
;  (setq auto-install-directory "~/.emacs.d/elisp/")
;  (auto-install-update-emacswiki-package-name t)
;  (auto-install-compatibility-setup))


; base settings
(cd "~/")


; language setting
;;(my-require-and-when 'un-define)
;;(set-language-environment "Japanese")
;;(set-terminal-coding-system 'utf-8)
;;(set-keyboard-coding-system 'utf-8)
;;(set-buffer-file-coding-system 'utf-8)
;;(setq default-buffer-file-coding-system 'utf-8)


; locale setting
(setenv "LC_TIME" "C")


; position and size setting
(setq default-frame-alist
      (append (list '(top . 20)         ; 起動時の表示位置(右から)
                    '(left . 100)       ; 起動時の表示位置(左から)
                    '(width . 160)       ; 起動時のサイズ(幅)
                    '(height . 64)      ; 起動時のサイズ(縦)
                    ;'(foreground-color . "green")       ; 文字の色
                    ;'(background-color . "black")       ; 背景の色
                    ;'(alpha . (nil 70 50 30))           ; 透過
                    ;'(cursor-color . "DarkOliveGreen1") ; カーソルの色
                    ;'(mouse-color . "DarkOliveGreen1") ; マウスポインタの色
                    ;'(font . "fontset-tt14") ; 使うフォントセット
                    )
              default-frame-alist))

; color setting
(global-font-lock-mode t)
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
;(set-face-foreground 'modeline "gray10")
;(set-face-background 'modeline "bisque3")
;(set-face-foreground 'mode-line-inactive "gray30")
;(set-face-background 'mode-line-inactive "gray85")
;(set-face-background 'region "DeepPink1")

;; color-theme
;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))


; highlight setting
(setq search-highlight t)
(setq query-replace-highlight t)
; highlight current line
(global-hl-line-mode)
(hl-line-mode t)
;(setq hl-line-face 'underline)
(set-face-background 'hl-line "DarkOliveGreen")
(my-require-and-when 'hi-lock)


; region setting
(transient-mark-mode t)
;(setq highlight-nonselected-windows t)
;(pc-selection-mode)
;(delete-selection-mode t)

;; visible-mark
;(install-elisp-from-emacswiki "visible-mark.el")
(my-require-and-when 'visible-mark)


; clipboard setting
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


; scroll setting
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)
(setq scroll-preserve-screen-position t)


; timestamp setting
(setq time-stamp-start "Time-stamp:[ \t]*<")
(setq time-stamp-end ">")


;; Etc
(setq inhibit-startup-message t)
(setq frame-title-format "%b")
(tool-bar-mode nil)
;(menu-bar-mode nil)
;(msb-mode t)
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
(my-require-and-when 'redo)


;; point-undo
;(install-elisp-from-emacswiki "point-undo.el")
(my-require-and-when 'point-undo)


;; kill-summary
;(install-elisp "http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el")
(autoload 'kill-summary "kill-summary" nil t)
(global-set-key "\M-y" 'kill-summary)


;; list-register
;(install-elisp "http://www.bookshelf.jp/elc/list-register.el")
(my-require-and-when 'list-register)

;; pit
(my-require-and-when 'pit)


;; a-menu
;; http://homepage.mac.com/zenitani/comp-e.html
;(my-require-and-when 'a-menu)


;; macros
;(load "_egoge-wash-out-colour")
(load "_elisp-font-lock-top-quote")
(load "_line-to-top-of-window")
