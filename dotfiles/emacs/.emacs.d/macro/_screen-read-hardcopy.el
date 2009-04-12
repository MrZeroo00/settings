;; screen-get/read-hardcopy
;; http://dev.ariel-networks.com/Members/matsuyama/complete-string-within-screen
(defun screen-get-hardcopy ()
  (let ((file (expand-file-name "~/tmp/screen-hardcopy")))
    (if (= (call-process "screen" nil nil nil "-X" "hardcopy" file) 0)
        file
      nil)))

(defun screen-read-hardcopy ()
  (let ((file (screen-get-hardcopy)))
    (if file
        (let ((buf (get-buffer-create "*Screen Hardcopy*")))
          (with-current-buffer buf
            (buffer-disable-undo)
            (erase-buffer)
            (insert-file-contents file))))))

;(defadvice try-expand-dabbrev-all-buffers (before try-expand-dabbrev-screen-hardcopy activate)
;  (screen-read-hardcopy))
;
;(setq hippie-expand-try-functions-list
;      '(...
;        try-expand-dabbrev-all-buffers # これがあるのを確認
;        ...))
