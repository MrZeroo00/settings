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


;;;; scroll setting
(setq scroll-conservatively 1)
'(setq scroll-step 1)
(setq scroll-margin 4)
(setq scroll-preserve-screen-position t)
(setq next-screen-context-lines 0)


;;;; timestamp setting
(setq time-stamp-start "Time-stamp:[ \t]*<")
(setq time-stamp-end ">")


;;;; Etc
(setq inhibit-startup-message t)
(setq frame-title-format "%b")
(menu-bar-mode nil)
(when window-system
  (tool-bar-mode nil)
  (msb-mode t)
  (set-scroll-bar-mode 'right))
(setq visible-bell t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq message-log-max 1000)
(setq gc-cons-threshold 3500000)
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 50000)
'(setq inhibit-default-init t)


;;;; macros
;;;(my-load-and-when "_egoge-wash-out-colour")
(my-load-and-when "_elisp-font-lock-top-quote")
(my-load-and-when "_line-to-top-of-window")
