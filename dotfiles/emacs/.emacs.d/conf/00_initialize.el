;;;; install-elisp
;;;(install-elisp-from-emacswiki "install-elisp.el")
'(my-require-and-when 'install-elisp
   (setq install-elisp-repository-directory "~/.emacs.d/elisp/"))


;;;; auto-install
;;;(install-elisp-from-emacswiki "auto-install.el")
'(my-require-and-when 'auto-install
   (setq auto-install-directory "~/.emacs.d/elisp/")
   (auto-install-update-emacswiki-package-name t)
   (auto-install-compatibility-setup))


;;;; base settings
(cd "~/")


;;;; language setting
'(my-require-and-when 'un-define)
'(set-language-environment "Japanese")
'(set-default-coding-systems 'utf-8)
'(set-terminal-coding-system 'utf-8)
'(set-keyboard-coding-system 'utf-8)
'(set-buffer-file-coding-system 'utf-8)
'(setq default-buffer-file-coding-system 'utf-8)
'(set-file-name-coding-system 'utf-8)
'(set-buffer-process-coding-system 'utf-8 'utf-8)
'(setq default-process-coding-system
       '(utf-8 . utf-8))
'(set-clipboard-coding-system 'utf-8)
'(set-language-environment 'utf-8)
'(prefer-coding-system 'utf-8)
'(add-hook 'find-file-hooks
           (lambda ()
             (setq coding-system-for-read 'utf-8)
             (setq coding-system-for-write 'utf-8)))
'(cond
  (run-darwin
   (my-require-and-when 'ucs-normalize
     (setq file-name-coding-system 'utf-8-hfs)
     (setq locale-coding-system 'utf-8-hfs))
   )
  ((or run-w32 run-cygwin)
   (setq file-name-coding-system 'utf-8)
   (setq locale-coding-system 'utf-8)
   ;; if use command prompt
   ;;(setq file-name-coding-system 'sjis)
   ;;(setq locale-coding-system 'sjis)
   ;; if use old Cygwin
   ;;(setq file-name-coding-system 'euc-jp)
   ;;(setq locale-coding-system 'euc-jp)
   )
  (t
   (setq file-name-coding-system 'utf-8)
   (setq locale-coding-system 'utf-8)
   ))


;;;; locale setting
(setenv "LC_TIME" "C")


;;;; position and size setting
(when window-system
  (setq default-frame-alist
        (append (list '(top . 0)        ; 起動時の表示位置(右から)
                      '(left . 0)       ; 起動時の表示位置(左から)
                      '(width . 80)     ; 起動時のサイズ(幅)
                      '(height . 50)    ; 起動時のサイズ(縦)
                      ;;'(foreground-color . "green")       ; 文字の色
                      ;;'(background-color . "black")       ; 背景の色
                      ;;'(alpha . (nil 70 50 30))           ; 透過
                      ;;'(cursor-color . "DarkOliveGreen1") ; カーソルの色
                      ;;'(mouse-color . "DarkOliveGreen1")  ; マウスポインタの色
                      ;;'(font . "fontset-tt14") ; 使うフォントセット
                      )
                default-frame-alist))

  (setq initial-frame-alist
        (append
         ;;'((fullscreen . fullboth))
         '((fullscreen . maximized))
         default-frame-alist)
        )

  ;; http://groups.google.com/group/carbon-emacs/msg/287876a967948923
  (defun toggle-fullscreen ()
    (interactive)
    (set-frame-parameter nil
                         'fullscreen
                         (if (frame-parameter nil
                                              'fullscreen)
                             nil 'fullboth)))
  (global-set-key [(meta return)] 'toggle-fullscreen))


;;;; color setting
(global-font-lock-mode t)
'(if window-system (progn
                     (set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
                     (set-face-foreground 'font-lock-string-face "purple")
                     (set-face-foreground 'font-lock-keyword-face "blue")
                     (set-face-foreground 'font-lock-function-name-face "blue")
                     (set-face-bold-p 'font-lock-function-name-face t)
                     (set-face-foreground 'font-lock-variable-name-face "black")
                     (set-face-foreground 'font-lock-type-face "LightSeaGreen")
                     (set-face-foreground 'font-lock-builtin-face "purple")
                     (set-face-foreground 'font-lock-constant-face "black")
                     (set-face-foreground 'font-lock-warning-face "blue")
                     (set-face-bold-p 'font-lock-warning-face nil)
                     (set-face-foreground 'modeline "gray10")
                     (set-face-background 'modeline "bisque3")
                     (set-face-foreground 'mode-line-inactive "gray30")
                     (set-face-background 'mode-line-inactive "gray85")
                     (set-face-background 'region "DeepPink1")
                     ))

;;;; color-theme
;;;; https://gna.org/projects/color-theme
(my-require-and-when 'color-theme
  (color-theme-initialize)
  (color-theme-clarity))
(when (not window-system)
  (set-face-background 'highlight "blue"))


;;;; scroll setting
'(setq scroll-conservatively 35)
'(setq scroll-margin 0)
'(setq scroll-step 1)
'(setq scroll-preserve-screen-position t)


;;;; timestamp setting
(setq time-stamp-start "Time-stamp:[ \t]*<")
(setq time-stamp-end ">")


;;;; Etc
(setq inhibit-startup-message t)
'(setq inhibit-default-init t)
(setq frame-title-format "%b")
(menu-bar-mode nil)
(when window-system
  (tool-bar-mode nil)
  (msb-mode t)
  (set-scroll-bar-mode 'right))
(setq visible-bell t)
(defalias 'yes-or-no-p 'y-or-n-p)
'(global-auto-revert-mode)
(setq message-log-max 1000)
(setq diff-switches "-u")
'(setq special-display-buffer-names '("*Help*" "*compilation*" "*interpretation*" "*Occur*"))
(setq gc-cons-threshold 3500000)
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 50000)


;;;; pit
(my-require-and-when 'pit)


;;;; a-menu
;;;; http://homepage.mac.com/zenitani/comp-e.html
'(my-require-and-when 'a-menu)


;;;; macros
;;;(my-load-and-when "_egoge-wash-out-colour")
(my-load-and-when "_elisp-font-lock-top-quote")
(my-load-and-when "_line-to-top-of-window")
