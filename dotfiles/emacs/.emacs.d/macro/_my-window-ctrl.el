;; my-window-ctrl
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=window%20resize%20my
(defun my-window-ctrl ()
  "Window size and position control."
  (interactive)
  (let* ((rlist (frame-parameters (selected-frame)))
         (tMargin (if (integerp (cdr (assoc 'top rlist)))
                      (cdr (assoc 'top rlist)) 0))
         (lMargin (if (integerp (cdr (assoc 'left rlist)))
                      (cdr (assoc 'left rlist)) 0))
         (displaywidth (x-display-pixel-width))
         (displayheight (x-display-pixel-height))
         (fObj (selected-frame))
         (nCHeight (frame-height))
         (nCWidth (frame-width))
         (ilist initial-frame-alist)
         (tMarginD (if (assoc 'top ilist)
                       (cdr (assoc 'top ilist)) tMargin))
         (lMarginD (if (assoc 'left ilist)
                       (cdr (assoc 'left ilist)) lMargin))
         (nCHeightD (if (assoc 'height ilist)
                        (cdr (assoc 'height ilist)) nCHeight))
         (nCWidthD (if (assoc 'width ilist)
                       (cdr (assoc 'width ilist)) nCWidth))
         endFlg
         c)
    (catch 'endFlg
      (while t
        (message "locate[%d:%d] size[%dx%d] display[%dx%d]"
                 lMargin tMargin nCWidth nCHeight
                 displaywidth displayheight)
        (set-mouse-position
         (if (featurep 'meadow)
             (selected-frame)
           (selected-window))
         nCWidth 0)
        (condition-case err
            (setq c (read-key-sequence nil))
          (error
           (throw 'endFlg t)))
        (cond ((or (equal c "f") (equal c [S-right]))
               ;;enlarge horizontally
               (set-frame-width fObj (setq nCWidth (+ nCWidth 2))))
              ((or (equal c "b") (equal c [S-left]))
               ;;shrink horizontally
               (set-frame-width fObj (setq nCWidth (- nCWidth 2))))
              ((or (equal c "n") (equal c [S-down]))
               ;;enlarge vertically
               (set-frame-height fObj (setq nCHeight (+ nCHeight 2))))
              ((or (equal c "p") (equal c [S-up]))
               ;;shrink vertically
               (set-frame-height fObj (setq nCHeight (- nCHeight 2))))
              ((or (equal c "\C-f") (equal c [right]))
               ;;move right
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin (+ lMargin 20))))))
              ((or (equal c "\C-b") (equal c [left]))
               ;;move left
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin (- lMargin 20))))))
              ((or (equal c "\C-n") (equal c [down]))
               ;;move down
               (modify-frame-parameters
                nil (list (cons 'top (setq tMargin (+ tMargin 20))))))
              ((or (equal c "\C-p") (equal c [up]))
               ;;move up
               (modify-frame-parameters
                nil (list (cons 'top (setq tMargin (- tMargin 20))))))
              ((or (equal c "\C-a") (equal c [home]))
               ;;move left end
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin 0)))))
              ((or (equal c "\C-e") (equal c [end]))
               ;;move left hand
               (modify-frame-parameters
                nil (list
                     (cons 'left
                           (setq lMargin
                                 (-
                                  (- displaywidth (frame-pixel-width))
                                  10) ;; 少し右端を空ける
                                 )))))
              ((or (equal c "\C-x") (equal c "x"))
               ;;maximize
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin 0))))
               (modify-frame-parameters
                nil (list (cons 'top (setq tMargin 0))))
               (set-frame-width
                ;; フレーム最大化時に (frame-width) で得た値
                fObj (setq nCWidth 154)) ;; 要変更
               ;; 環境によっては，以下でもうまくいくかも
               ;; fObj (setq nCWidth (/ displaywidth (frame-char-width))))
               (set-frame-height
                ;; フレーム最大化時に (frame-height) で得た値
                fObj (setq nCHeight 34)) ;; 要変更
               ;; 環境によっては，以下でもうまくいくかも
               ;; (- (/ displayheight (frame-char-height)) 8)))
               )
              ((or (equal c "\C-d") (equal c "d"));;default size
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin lMarginD))))
               (modify-frame-parameters
                nil (list (cons 'top (setq tMargin tMarginD))))
               (set-frame-width fObj (setq nCWidth nCWidthD))
               (set-frame-height fObj (setq nCHeight nCHeightD))
               )
              ((or (equal c "\C-i") (equal c "i"));;initial size
               (modify-frame-parameters
                nil (list (cons 'left (setq lMargin 0))))
               (modify-frame-parameters
                nil (list (cons 'top (setq tMargin 0))))
               (set-frame-width fObj (setq nCWidth 80))
               (set-frame-height fObj (setq nCHeight 32))
               )
              ((equal c "w");;write out
               (insert (concat
                        "'(width . " (int-to-string nCWidth) ")\n"
                        "'(height . " (int-to-string nCHeight) ")\n"
                        "'(top . " (int-to-string tMargin) ")\n"
                        "'(left . " (int-to-string lMargin) ")\n"))
               (throw 'endFlg t))
              ((or (equal c "\C-z") (equal c "z"))
               (iconify-or-deiconify-frame)
               (throw 'endFlg t))
              ((equal c "q") (message "quit") (throw 'endFlg t))
              ;; デフォルトは終了
              (t (message "quit") (throw 'endFlg t))
              )))))
