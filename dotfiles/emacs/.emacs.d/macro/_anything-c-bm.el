;; anything-c-bm
;; http://d.hatena.ne.jp/rubikitch/20080913/1221295254
(require 'bm)
(defvar anything-c-source-bm
  '((name . "Visible Bookmarks")
    (init . anything-c-source-bm-init)
    (candidates-in-buffer)
    (action . (("Goto line" . (lambda (candidate)
                                (goto-line (string-to-number candidate))))))))
(defun anything-c-source-bm-init ()
  (let ((bookmarks (bm-lists))
        (buf (anything-candidate-buffer 'global)))
    (dolist (bm (sort* (append (car bookmarks) (cdr bookmarks))
                       '< :key 'overlay-start))
      (let ((start (overlay-start bm))
            (end (overlay-end bm))
            (annotation (or (overlay-get bm 'annotation) "")))
        (unless (< (- end start) 1)   ; org => (if (< (- end start) 2)
          (let ((str (format "%7d: [%s]: %s\n"
                             (line-number-at-pos start)
                             annotation
                             (buffer-substring start (1- end)))))
            (with-current-buffer buf (insert str))))))))
