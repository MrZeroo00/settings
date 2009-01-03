(windmove-default-keybindings)
;(global-set-key (quote [kp-8]) (quote windmove-up))
;(global-set-key (quote [kp-2]) (quote windmove-down))
;(global-set-key (quote [kp-6]) (quote windmove-right))
;(global-set-key (quote [kp-4]) (quote windmove-left))


;; windows (window manager for Emacs)
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=windows%20screen
;(install-elisp "http://www.gentei.org/~yuuji/software/windows.el")
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
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/widen-window-mode/trunk/widen-window.el")
(require 'widen-window)
(global-widen-window-mode t)
(setq ww-ratio 0.75)
(diminish 'widen-window-mode " WW")
;(define-key ctl-x-map "ww" 'global-widen-window-mode)

(setq ww-advised-functions
      (append '(windmove-up
		windmove-down
		windmove-right
		windmove-left)
              ww-advised-functions))


;; master
;; http://www.geocities.com/kensanata/elisp/master.el.txt
(require 'master)
;(install-elisp "http://www.bookshelf.jp/elc/dired-master.el")
(load "dired-master")


;; winhist
;(require 'winhist)
;(winhist-mode 1)


;; window-toggle-division
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=toggle%20division
(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )

    (switch-to-buffer-other-window other-buf)
    (other-window -1)))


;; swap-screen
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=swap%20screen
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
;(global-set-key [f2] 'swap-screen)
;(global-set-key [S-f2] 'swap-screen-with-cursor)


;; my-window-ctrl
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=window%20resize%20my
;(defun my-window-ctrl ()
;  "Window size and position control."
;  (interactive)
;  (let* ((rlist (frame-parameters (selected-frame)))
;         (tMargin (if (integerp (cdr (assoc 'top rlist)))
;                      (cdr (assoc 'top rlist)) 0))
;         (lMargin (if (integerp (cdr (assoc 'left rlist)))
;                      (cdr (assoc 'left rlist)) 0))
;         (displaywidth (x-display-pixel-width))
;         (displayheight (x-display-pixel-height))
;         (fObj (selected-frame))
;         (nCHeight (frame-height))
;         (nCWidth (frame-width))
;         (ilist initial-frame-alist)
;         (tMarginD (if (assoc 'top ilist)
;                       (cdr (assoc 'top ilist)) tMargin))
;         (lMarginD (if (assoc 'left ilist)
;                       (cdr (assoc 'left ilist)) lMargin))
;         (nCHeightD (if (assoc 'height ilist)
;                        (cdr (assoc 'height ilist)) nCHeight))
;         (nCWidthD (if (assoc 'width ilist)
;                       (cdr (assoc 'width ilist)) nCWidth))
;         endFlg
;         c)
;    (catch 'endFlg
;      (while t
;        (message "locate[%d:%d] size[%dx%d] display[%dx%d]"
;                 lMargin tMargin nCWidth nCHeight
;                 displaywidth displayheight)
;        (set-mouse-position
;         (if (featurep 'meadow)
;             (selected-frame)
;           (selected-window))
;         nCWidth 0)
;        (condition-case err
;            (setq c (read-key-sequence nil))
;          (error
;           (throw 'endFlg t)))
;        (cond ((or (equal c "f") (equal c [S-right]))
;               ;;enlarge horizontally
;               (set-frame-width fObj (setq nCWidth (+ nCWidth 2))))
;              ((or (equal c "b") (equal c [S-left]))
;               ;;shrink horizontally
;               (set-frame-width fObj (setq nCWidth (- nCWidth 2))))
;              ((or (equal c "n") (equal c [S-down]))
;               ;;enlarge vertically
;               (set-frame-height fObj (setq nCHeight (+ nCHeight 2))))
;              ((or (equal c "p") (equal c [S-up]))
;               ;;shrink vertically
;               (set-frame-height fObj (setq nCHeight (- nCHeight 2))))
;              ((or (equal c "\C-f") (equal c [right]))
;               ;;move right
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin (+ lMargin 20))))))
;              ((or (equal c "\C-b") (equal c [left]))
;               ;;move left
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin (- lMargin 20))))))
;              ((or (equal c "\C-n") (equal c [down]))
;               ;;move down
;               (modify-frame-parameters
;                nil (list (cons 'top (setq tMargin (+ tMargin 20))))))
;              ((or (equal c "\C-p") (equal c [up]))
;               ;;move up
;               (modify-frame-parameters
;                nil (list (cons 'top (setq tMargin (- tMargin 20))))))
;              ((or (equal c "\C-a") (equal c [home]))
;               ;;move left end
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin 0)))))
;              ((or (equal c "\C-e") (equal c [end]))
;               ;;move left hand
;               (modify-frame-parameters
;                nil (list
;                     (cons 'left
;                           (setq lMargin
;                                 (-
;                                  (- displaywidth (frame-pixel-width))
;                                  10) ;; 少し右端を空ける
;                                 )))))
;              ((or (equal c "\C-x") (equal c "x"))
;               ;;maximize
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin 0))))
;               (modify-frame-parameters
;                nil (list (cons 'top (setq tMargin 0))))
;               (set-frame-width
;                ;; フレーム最大化時に (frame-width) で得た値
;                fObj (setq nCWidth 154)) ;; 要変更
;               ;; 環境によっては，以下でもうまくいくかも
;               ;; fObj (setq nCWidth (/ displaywidth (frame-char-width))))
;               (set-frame-height
;                ;; フレーム最大化時に (frame-height) で得た値
;                fObj (setq nCHeight 34)) ;; 要変更
;               ;; 環境によっては，以下でもうまくいくかも
;               ;; (- (/ displayheight (frame-char-height)) 8)))
;               )
;              ((or (equal c "\C-d") (equal c "d")) ;;default size
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin lMarginD))))
;               (modify-frame-parameters
;                nil (list (cons 'top (setq tMargin tMarginD))))
;               (set-frame-width fObj (setq nCWidth nCWidthD))
;               (set-frame-height fObj (setq nCHeight nCHeightD))
;               )
;              ((or (equal c "\C-i") (equal c "i")) ;;initial size
;               (modify-frame-parameters
;                nil (list (cons 'left (setq lMargin 0))))
;               (modify-frame-parameters
;                nil (list (cons 'top (setq tMargin 0))))
;               (set-frame-width fObj (setq nCWidth 80))
;               (set-frame-height fObj (setq nCHeight 32))
;               )
;              ((equal c "w") ;;write out
;               (insert (concat
;                        "'(width . " (int-to-string nCWidth) ")\n"
;                        "'(height . " (int-to-string nCHeight) ")\n"
;                        "'(top . " (int-to-string tMargin) ")\n"
;                        "'(left . " (int-to-string lMargin) ")\n"))
;               (throw 'endFlg t))
;              ((or (equal c "\C-z") (equal c "z"))
;               (iconify-or-deiconify-frame)
;               (throw 'endFlg t))
;              ((equal c "q") (message "quit") (throw 'endFlg t))
;              ;; デフォルトは終了
;              (t (message "quit") (throw 'endFlg t))
;              )))))
;
;(global-set-key "\C-z" 'my-window-ctrl)
