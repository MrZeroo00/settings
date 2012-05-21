(eval-when-compile (require 'cl))
(require 'vc-git)
(require 'screen-base)
(provide 'screen-vc)

(defvar anything-git-projects-screen-feature 'windows)

(defun screen-vc-parent-directory (path)
  (let ((parent (file-name-directory (directory-file-name (file-name-directory path)))))
    (if (string-equal parent path) nil parent)))

(defun screen-vc-get-toplevel (&optional screen) (screen-base-get-parameter 'screen-vc-toplevel screen))
(defun screen-vc-set-toplevel (dir &optional screen) (screen-base-set-parameter 'screen-vc-toplevel dir screen))
;; (when (featurep 'windows)
;;   (screen-base-register-parameters-to-save 'screen-vc-toplevel))

(defvar screen-vc-current-file-toplevel-cache t)
(make-variable-buffer-local 'screen-vc-current-file-toplevel-cache)
(defun screen-vc-current-file-toplevel ()
  (if (eq screen-vc-current-file-toplevel-cache t)
      (setq screen-vc-current-file-toplevel-cache
            (vc-git-root (file-truename
                          (if (buffer-file-name)
                              (file-name-directory (buffer-file-name))
                            default-directory))))
    screen-vc-current-file-toplevel-cache))

(defun screen-vc-current-toplevel ()
  (or
   (screen-vc-get-toplevel)
   (screen-vc-current-file-toplevel)))

;; return git toplevel of root project
(defun screen-vc-root ()
  (flet ((iter (path)
               (let ((p (and path (vc-git-root path))))
                 (or (and p (iter (screen-vc-parent-directory p))) p))))
    (iter (file-truename (if (buffer-file-name)
                             (file-name-directory (buffer-file-name))
                           default-directory)))))

(defvar screen-vc-current-file-root-cache t)
(make-variable-buffer-local 'screen-vc-current-file-root-cache)
(defun screen-vc-current-file-root ()
  (if (eq screen-vc-current-file-root-cache t)
    (setq screen-vc-current-file-root-cache (screen-vc-root))
    screen-vc-current-file-root-cache))
