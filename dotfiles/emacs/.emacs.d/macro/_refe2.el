;; refe2
;; http://d.hatena.ne.jp/rubikitch/20071228/rubyrefm
(defun refe2 (kw)
  (interactive "sReFe2: ")
  (with-current-buffer (get-buffer-create (concat "*refe2:" kw "*"))
    (when (zerop (buffer-size))
      (call-process "refe2" nil t t kw)
      (diff-mode))
    (setq minibuffer-scroll-window (get-buffer-window (current-buffer) t))
    (goto-char (point-min))
    (display-buffer (current-buffer))))
