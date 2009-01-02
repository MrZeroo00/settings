(require 'anything)
(provide 'anything-goodies)

;;; (@* "Scrape data in candidate-in-buffer buffer")
(defun anything-candidate-in-buffer-scraper (buf search-proc &optional filter)
  (with-current-buffer buf
    (goto-char (point-min))
    (let ((anything-pattern (substring-no-properties anything-pattern)))
      (cond
      ;; list all candidates
        ((zerop (length anything-pattern))
         (loop with cnt = anything-candidate-number-limit
               until (or (zerop cnt) (eobp))
               collect (buffer-substring-no-properties (line-beginning-position)
                                                       (line-end-position))
               do (decf cnt) (forward-line)))
      ;; if pattern may cause infinit loop, return nothing
      ((or (string-match (rx bol (+ space) eol) anything-pattern)
           (string-equal "" anything-pattern)) nil)
      ;; search
      (t (loop with cnt = anything-candidate-number-limit
               while (and (not (eobp))
                          (> cnt 0)
                          (funcall search-proc))
               when (if (not filter)
                        t
                        (funcall filter))
               collect (buffer-substring-no-properties (line-beginning-position)
                                                       (line-end-position))
               do (decf cnt)
                     (forward-line)))))))

;;; (@* "high light region form persistent-action")
(defvar anything-c-persistent-highlight-overlay
  (make-overlay (point) (point)))

(defun anything-persistent-highlight-point (start &optional end face rec)
  (goto-char start)
  (when (overlayp anything-c-persistent-highlight-overlay)
    (move-overlay anything-c-persistent-highlight-overlay
                  start
                  (or end (line-end-position))
                  (current-buffer)))
  (overlay-put anything-c-persistent-highlight-overlay 'face (or face 'highlight))
  (when rec
    (recenter)))

(add-hook 'anything-cleanup-hook
          (lambda ()
            (when (overlayp anything-c-persistent-highlight-overlay)
              (delete-overlay anything-c-persistent-highlight-overlay))))

(defadvice anything-mark-current-line
    (after anything-execute-persistent-action first (&rest ret) activate)
  (when (and (anything-window)
             (anything-get-selection)
             (not (assoc 'explicit-persistent-action (anything-get-current-source)))
             (assoc 'persistent-action (anything-get-current-source)))
    (save-excursion
      (anything-execute-persistent-action))))

(defadvice anything-move-selection (after screen-top activate)
  "Display at the top of window when moving selection to the prev/next source."
  (if (and (anything-window)
           (eq unit 'source))
      (save-selected-window
        (select-window (get-buffer-window anything-buffer 'visible))
        (set-window-start (selected-window)
                          (save-excursion (forward-line -1) (point))))))

(unless (boundp 'anything-default-directory)
  (defvar anything-default-directory default-directory))