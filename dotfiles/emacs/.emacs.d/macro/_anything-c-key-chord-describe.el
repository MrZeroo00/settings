;; anything-c-key-chord-describe
;; http://d.hatena.ne.jp/IMAKADO/20081228/1230393578
(defvar anything-c-source-key-chord-describe
  `((name . "key-chord describe bindings")
    (action . (("Call Interactively" . (lambda (c)
                                         (call-interactively (intern c))))
               ("Add to kill-ring" . kill-new)))
    (init . (lambda ()
              (with-current-buffer (anything-candidate-buffer 'global)
                (save-selected-window
                  (call-interactively 'key-chord-describe))
                (let ((los (with-current-buffer "*Help*"
                             (loop initially (goto-char (point-min))
                                   while (re-search-forward (rx "<key-chord>"
                                                                (1+ space)
                                                                (group
                                                                 (* not-newline))) nil t)
                                   unless (save-excursion (progn (beginning-of-line)
                                                                 (re-search-forward "Prefix Command" nil t)))
                                   collect (match-string-no-properties 1)))))
                  (insert (mapconcat 'identity los "\n"))))))
    (display-to-real . (lambda (line)
                         ;; (rx bol (= 3 not-newline) (+ space) (group (+ print)))
                         (when (string-match "\\(?:^.\\{3\\}[[:space:]]+\\([[:print:]]+\\)\\)"
                                             line)
                           (match-string 1 line))))
    (candidates-in-buffer)))


(defun anything-c-key-chord-describe ()
  (interactive)
  (anything '(anything-c-source-key-chord-describe)))
