(windmove-default-keybindings)
;(global-set-key (quote [kp-8]) (quote windmove-up))
;(global-set-key (quote [kp-2]) (quote windmove-down))
;(global-set-key (quote [kp-6]) (quote windmove-right))
;(global-set-key (quote [kp-4]) (quote windmove-left))


;; windows (window manager for Emacs)
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=windows%20screen
;(install-elisp "http://www.gentei.org/~yuuji/software/windows.el")
(my-require-and-when 'windows
  (setq win:switch-prefix "\C-z")
  (define-key global-map win:switch-prefix nil)
  (setq win:base-key ?`)       ;; ` は「直前の状態」
  (setq win:max-configs 27)    ;; ` 〜 z は 27 文字
  (setq win:quick-selection nil) ;; C-c 英字 に割り当てない

  (setq win:use-frame nil)
  (win:startup-with-window)
  (define-key ctl-x-map "C" 'see-you-again)

  (setq win-save-timer (run-with-idle-timer 3600 t 'win-save-all-configurations)))


;; widen-window
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/widen-window-mode/trunk/widen-window.el")
(my-require-and-when 'widen-window
  (global-widen-window-mode t)
  (setq ww-ratio 0.625)
  (define-key ctl-x-map "ww" 'global-widen-window-mode)

  (setq ww-advised-functions
	(append '(windmove-up
		  windmove-down
		  windmove-right
		  windmove-left)
		ww-advised-functions)))


;; master
;; http://www.geocities.com/kensanata/elisp/master.el.txt
;(install-elisp "http://www.bookshelf.jp/elc/dired-master.el")
(my-autoload-and-when 'master-mode "master"
		      (my-load-and-when "dired-master"))


;; split-root
;(install-elisp "http://nschum.de/src/emacs/split-root/split-root.el")
(my-require-and-when 'split-root)


;; winhist
'(my-require-and-when 'winhist
  (winhist-mode t))


;; other-window-or-split
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "C-o") 'other-window-or-split)


;; macros
(my-load-and-when "_window-toggle-division")
'(my-load-and-when "_swap-screen"
  (global-set-key [f2] 'swap-screen)
  (global-set-key [S-f2] 'swap-screen-with-cursor))
'(my-load-and-when "_my-window-ctrl"
  (global-set-key "\C-z" 'my-window-ctrl))
