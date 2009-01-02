  (defadvice dired-display-file
  (after master-mode activate)
  (master-mode 1)
  (master-set-slave (find-file-noselect (dired-get-filename))))

(defvar dired-view-file-list nil)
(defun dired-view-file-scroll (&optional arg)
  (interactive)
  (cond
   ((file-directory-p (dired-get-filename))
    (call-interactively 'dired-advertised-find-file))
   (t
    (save-window-excursion
      (if (get-file-buffer (dired-get-filename))
          (if (and
               (buffer-file-name (window-buffer (next-window)))
               (string=
                (expand-file-name (buffer-file-name (window-buffer (next-window))))
                (expand-file-name (dired-get-filename))))
              ()
            (switch-to-buffer (get-file-buffer (dired-get-filename))))
        (setq dired-view-file-list
              (cons
               (find-file-other-window (dired-get-filename))
               dired-view-file-list))))
    (master-set-slave (get-file-buffer (dired-get-filename)))
    (if arg
        (master-says-scroll-down)
      (master-says-scroll-up)))))

(defun dired-view-file-scroll-down ()
  (interactive)
  (dired-view-file-scroll t))

(defun dired-view-file-kill-buffer ()
  (interactive)
  (while dired-view-file-list
    (if (buffer-name (car dired-view-file-list))
        (progn
          (set-buffer (car dired-view-file-list))
          (if (buffer-modified-p)
              ()
            (kill-buffer (car dired-view-file-list)))))
    (setq dired-view-file-list
          (cdr dired-view-file-list))))

(defadvice dired-my-up-directory
  (after kill-buffers activate)
  (dired-view-file-kill-buffer))

(defadvice quit-window
  (before kill-buffers activate)
  (if (eq major-mode 'dired-mode)
      (dired-view-file-kill-buffer)))

(defadvice kill-buffer
  (before kill-buffers activate)
  (if (eq major-mode 'dired-mode)
      (dired-view-file-kill-buffer)))

(defadvice dired-advertised-find-file
  (after kill-buffers activate)
  (if (eq major-mode 'dired-mode)
      (dired-view-file-kill-buffer)))

(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map " " 'dired-view-file-scroll)
     (define-key dired-mode-map "b" 'dired-view-file-scroll-down)))