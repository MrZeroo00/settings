;; windows (window manager for Emacs)
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=windows%20screen
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
(setq win:base-key ?`) ;; ` は「直前の状態」
(setq win:max-configs 27) ;; ` 〜 z は 27 文字
(setq win:quick-selection nil) ;; C-c 英字 に割り当てない

(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)


;; widen-window
(require 'widen-window)
(global-widen-window-mode t)
(setq ww-ratio 0.75)
(diminish 'widen-window-mode " WW")


;; master
(require 'master)
(load "dired-master")
