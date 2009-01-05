;; anything-select-source
;; http://d.hatena.ne.jp/rubikitch/20080911/1221126070
(defun anything-nest (&rest same-as-anything)
  "Nested `anything'. If you use `anything' within `anything', use it."
  (with-selected-window (anything-window)
    (let (anything-current-position
          anything-current-buffer
          (orig-anything-buffer anything-buffer)
          anything-pattern
          anything-buffer
          anything-sources
          anything-compiled-sources
          anything-buffer-chars-modified-tick
          (anything-samewindow t)
          (enable-recursive-minibuffers t))
      (unwind-protect
          (apply #'anything same-as-anything)
        (anything-initialize-overlays orig-anything-buffer)
        (add-hook 'post-command-hook 'anything-check-minibuffer-input)))))

;; [2008/09/03] <<<source selector>>>
(defun anything-displaying-source-names ()
  (with-current-buffer anything-buffer
    (goto-char (point-min))
    (loop with pos
          while (setq pos (next-single-property-change (point) 'anything-header))
          do (goto-char pos)
          collect (buffer-substring-no-properties (point-at-bol)(point-at-eol))
          do (forward-line 1))))

(defun anything-select-source ()
  (interactive)
  (let ((default (assoc-default 'name (anything-get-current-source)))
        (source-names (anything-displaying-source-names))
        (all-source-names (mapcar (lambda (s) (assoc-default 'name s))
                                  (anything-get-sources))))
    (setq anything-candidate-number-limit 9999)
    (anything-aif
        (let (anything-source-filter)
          (anything-nest '(((name . "Anything Source")
                            (candidates . source-names)
                            (action . identity))
                           ((name . "Anything Source (ALL)")
                            (candidates . all-source-names)
                            (action . identity)))
                         nil "Source: " nil
                         default "*anything select source*"))
        (anything-set-source-filter (list it))
      (anything-set-source-filter nil))))
