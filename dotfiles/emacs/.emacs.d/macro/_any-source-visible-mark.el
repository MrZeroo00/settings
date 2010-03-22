;;;; any-source-visible-mark
;;; Anything.el で今見えている候補群を一挙にマークする anything 実行中用コマンド
;;; http://d.hatena.ne.jp/hchbaw/20100226/1267200447
(defun my-anything-activate-source-visible-mark ()
  "Activate the visible mark for each candidate of the current source."
  (interactive)
  (my-anything-activate-source-visible-mark-1))

(defun my-anything-deactivate-source-visible-mark ()
  "Deactivate the visible mark for each candidate of the current source."
  (interactive)
  (my-anything-activate-source-visible-mark-1 t))

(defun my-anything-activate-source-visible-mark-1 (&optional deactivatep)
  (my-anything-toggle-source-visible-mark
   (lambda ()
     (cond (deactivatep (my-anything-visible-mark-exists-p))
           (t (not (my-anything-visible-mark-exists-p)))))))

(defun my-anything-visible-mark-exists-p ()
  (find-if (lambda (x) (memq x anything-visible-mark-overlays))
           (overlays-at (point))))

(defun my-anything-toggle-source-visible-mark (togglep)
  "For each candidate of the current source, if TOGGLEP returns non-nil then toggle its visible mark."
  (unless (or (zerop (buffer-size (get-buffer (anything-buffer-get))))
              (not (anything-window)))
    (with-anything-window
      (unwind-protect
           (save-excursion
             (destructuring-bind (beg . end)
                 (my-anything-bounds-of-source-at-point)
               (save-restriction
                 (narrow-to-region beg end)
                 (flet ((anything-next-line ())) ;; assume no active advices.
                   (loop initially (goto-char (point-min)) (forward-line 1)
                         until (eobp) do
                         (anything-mark-current-line)
                         (when (funcall togglep)
                           (anything-toggle-visible-mark))
                         (forward-line 1))))))
        (anything-mark-current-line)))))

(defun my-anything-bounds-of-source-at-point ()
  (labels ((beginning-of-source ()
             (goto-char (or (anything-get-previous-header-pos) (point-min)))
             (forward-line 0))
           (end-of-source ()
             (goto-char (or (anything-get-next-header-pos) (point-max)))
             (unless (eobp) (forward-line -1)))
           (source-start-pos ()
             (save-excursion (beginning-of-source) (point)))
           (source-end-pos ()
             (save-excursion (end-of-source) (point))))
    (cons (source-start-pos) (source-end-pos))))

(define-key anything-map (kbd "s-a") 'my-anything-activate-source-visible-mark)
(define-key anything-map (kbd "s-c s-a") 'my-anything-deactivate-source-visible-mark)
(define-key anything-map (kbd "s-c s-c s-d")
  (lambda ()
    (interactive)
    (message ">%S" anything-marked-candidates)
    (message "%S" anything-visible-mark-overlays)
    (message "%S" (mapcar (lambda (x)
                            (substring-no-properties (overlay-get x 'string)))
                          anything-visible-mark-overlays))
    (message "%S" (length anything-visible-mark-overlays))))

