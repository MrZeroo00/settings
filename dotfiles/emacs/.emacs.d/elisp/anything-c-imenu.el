(require 'anything)
(require 'imenu)

(unless (boundp 'anything-c-source-imenu)
  (defvar anything-c-source-imenu))

(setq anything-c-source-imenu
      `((name . "Imenu")
        (init . anything-c-imenu-init)
        (candidates-in-buffer)
        (get-line . buffer-substring)
        ,(if (fboundp 'anything-persistent-highlight-point)
             '(persistent-action . anything-c-imenu-preview)
             '(--unimplemented-attribute))
        (cached-candidates . nil)
        (action
         . (("Goto point" . (lambda (m)
                              (goto-char (marker-position m))))
            ("Re-eval" . (lambda (m)
                           (save-excursion
                             (let ((beg (goto-char (marker-position m))))
                               (forward-sexp)
                               (eval-region beg (point))))))))))

(defun anything-c-imenu-preview (c)
  "highlight line that selected item is exist."
  (anything-aif
      (case (type-of c)
        ('marker (marker-position c))
        ('number c)
        (otherwise (error (format "%c is not point or merker"
                                  (prin1-to-string c)))))
      (progn
        (goto-char it)
        (anything-persistent-highlight-point
         (line-beginning-position)))))

(defun anything-c-imenu-init ()
  (with-current-buffer (anything-candidate-buffer 'local)
    (let ((tick (buffer-modified-tick))
          (imenu-auto-rescan t))
      (loop for c
            in (if (anything-current-buffer-is-modified)
                   (let ((candidates (anything-c-imenu-make-candidates-alist
                                      anything-current-buffer)))
                     (setq anything-c-source-imenu
                           (acons 'cached-candidates
                                  candidates
                                  (delete* 'cached-candidates
                                           anything-c-source-imenu
                                           :key 'car)))
                     candidates)
                   (assoc-default 'cached-candidates anything-c-source-imenu))
            do (insert (propertize (car c)
                                   'anything-realvalue
                                   (cdr c)) "\n")))))

(defun anything-c-imenu-make-candidates-alist (&optional buffer)
  "make (symbol . marker) by using imenu"
  (with-current-buffer (or buffer (current-buffer))
    (let* ((imenu-index (save-excursion
                          (funcall imenu-create-index-function)))
           not-funcs
           funcs)
      ;; indexs -> not-funcs, funcs
      (loop for elem in imenu-index
            if (and (consp elem)
                    (stringp (car elem))
                    (listp (cdr elem)))
              do (push elem not-funcs)
            else
              do (push elem funcs))
      ;; not-funcs + funcs
      (append
       (apply 'append
              ;; (("Variables" . (...)) ("Types" . (...)) ...)
              (mapcar
               (lambda (lst)
                 ;; ("Variables" . (...)) -> ("Variables / name" . #<merker>)
                 (mapcar (lambda (elem)
                           (cons (format "%s / %s" (car lst) (car elem))
                                 (cdr elem)))
                         (cdr lst)))
               not-funcs))
       funcs))))

;;; (anything-c-imenu-make-candidates-alist)
(expectations
  (expect (non-nil)
    (anything-c-imenu-make-candidates-alist))
  (expect (non-nil)
    (anything-test-candidates '(anything-c-source-imenu))))

(provide 'anything-c-imenu)