(iswitchb-mode t)

;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=iswitchb
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )

(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
            "No buffer matching `%s', "
            buf))
  (sit-for 1)
  (call-interactively 'find-file buf))

(defun iswitchb-buffer (arg)
  "Switch to another buffer.

The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=iswitchb-exhibit
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=iswitchb-migemo
(setq iswitchb-regexp t)
(setq iswitchb-use-migemo-p t)
(defadvice iswitchb-get-matched-buffers
  (before iswitchb-use-migemo activate)
  "iswitchb で migemo を使ってみる。"
  (when iswitchb-use-migemo-p
    (ad-set-arg
     0 (migemo-get-pattern
        (ad-get-arg 0)))))
