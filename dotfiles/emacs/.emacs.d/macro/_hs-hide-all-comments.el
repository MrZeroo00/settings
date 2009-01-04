;; hs-hide-all-comments
;; http://sheepman.sakura.ne.jp/diary/?date=20050131
(defun hs-hide-all-comments ()
  (interactive)
  (hs-life-goes-on
   (message "Hiding all comments ...")
   (save-excursion
     (hs-flag-region (point-min) (point-max) nil) ; eliminate weirdness
     (goto-char (point-min))
     (let (c-reg (count 0))
       (while (re-search-forward hs-c-start-regexp (point-max) t)
         (if (match-beginning 1) ;; we have found a block beginning
             (progn
               (goto-char (match-beginning 1))
               (hs-hide-block-at-point t)
               (message "Hiding ... %d" (setq count (1+ count))))
           ;;found a comment
           (setq c-reg (hs-inside-comment-p))
           (if (and c-reg (car c-reg))
               (if (> (count-lines (car c-reg) (nth 1 c-reg))
                      (if hs-show-hidden-short-form 1 2))
                   (progn
                     (hs-hide-block-at-point t c-reg)
                     (message "Hiding ... %d" (setq count (1+ count))))
                 (goto-char (nth 1 c-reg))))))))
   (hs-safety-is-job-n))
  (beginning-of-line)
  (message "Hiding all comments ... done")
  (run-hooks 'hs-hide-hook))
