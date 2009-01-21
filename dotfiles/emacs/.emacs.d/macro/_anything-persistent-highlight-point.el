;; anything-persistent-highlight-point
; http://d.hatena.ne.jp/rubikitch/20090106/anythinggrep
(defun anything-persistent-highlight-point (start &optional end buf face rec)
  (goto-char start)
  (when (overlayp anything-c-persistent-highlight-overlay)
    (move-overlay anything-c-persistent-highlight-overlay
                  start
                  (or end (line-end-position))
                  buf))
  (overlay-put anything-c-persistent-highlight-overlay 'face (or face 'highlight))
  (when rec
    (recenter)))

(add-hook 'anything-cleanup-hook
          (lambda ()
            (when (overlayp anything-c-persistent-highlight-overlay)
              (delete-overlay anything-c-persistent-highlight-overlay))))
