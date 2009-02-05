;; org-next/previous-visible-link
;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
(defun org-next-visible-link ()
  "Move forward to the next link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-min))
    (message "Link search wrapped back to beginning of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 2 a)))
    (while (and (setq srch (re-search-forward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (prog1 (not (eq (org-invisible-p) 'org-link))
                  (goto-char (match-end 0)))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))

(defun org-previous-visible-link ()
  "Move backward to the previous link.
If the link is in hidden text, expose it."
  (interactive)
  (when (and org-link-search-failed (eq this-command last-command))
    (goto-char (point-max))
    (message "Link search wrapped back to end of buffer"))
  (setq org-link-search-failed nil)
  (let* ((pos (point))
	 (ct (org-context))
	 (a (assoc :link ct))
         srch)
    (if a (goto-char (nth 1 a)))
    (while (and (setq srch (re-search-backward org-any-link-re nil t))
                (goto-char (match-beginning 0))
                (not (eq (org-invisible-p) 'org-link))))
    (if srch
        (goto-char (match-beginning 0))
      (goto-char pos)
      (setq org-link-search-failed t)
      (error "No further link found"))))
;(define-key org-mode-map "\M-n" 'org-next-visible-link)
;(define-key org-mode-map "\M-p" 'org-previous-visible-link)
