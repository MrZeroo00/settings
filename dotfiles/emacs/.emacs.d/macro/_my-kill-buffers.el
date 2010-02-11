;; my-kill-buffers
;; http://d.hatena.ne.jp/rubikitch/20090306/1236299705
(require 'cl)
(defun my-kill-buffers ()
  (interactive)
  (loop for buf in (buffer-list)
        for bn = (buffer-name buf)
        unless (string-match (rx bol (or (+ space) "#")) bn)
        do (kill-buffer buf)))
