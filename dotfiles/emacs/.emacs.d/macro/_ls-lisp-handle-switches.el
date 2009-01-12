;; ls-lisp-handle-switches
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=directory%20first
(defun ls-lisp-handle-switches (file-alist switches)
  ;; FILE-ALIST's elements are (FILE . FILE-ATTRIBUTES).
  ;; Return new alist sorted according to SWITCHES which is a list of
  ;; characters.  Default sorting is alphabetically.
  (let (index)
    (setq file-alist
          (sort file-alist
                (cond
                 ((memq ?S switches)    ; sorted on size
                  (function
                   (lambda (x y)
                     ;; 7th file attribute is file size
                     ;; Make largest file come first
                     (if (equal (nth 0 (cdr y))
                                (nth 0 (cdr x)))
                         (< (nth 7 (cdr y))
                            (nth 7 (cdr x)))
                       (nth 0 (cdr x))))))
                 ((memq ?t switches)    ; sorted on time
                  (setq index (ls-lisp-time-index switches))
                  (function
                   (lambda (x y)
                     (if (equal (nth 0 (cdr y))
                                (nth 0 (cdr x)))
                         (ls-lisp-time-lessp (nth index (cdr y))
                                             (nth index (cdr x)))
                       (nth 0 (cdr x))
                       ))))
                 ((memq ?X switches)    ; sorted on ext
                  (function
                   (lambda (x y)
                     (if (equal (nth 0 (cdr y))
                                (nth 0 (cdr x)))
                         (string-lessp (file-name-extension (upcase (car x)))
                                       (file-name-extension (upcase (car y))))
                       (nth 0 (cdr x))))))
                 (t                     ; sorted alphabetically
                  (if ls-lisp-dired-ignore-case
                      (function
                       (lambda (x y)
                         (if (equal (nth 0 (cdr y))
                                    (nth 0 (cdr x)))
                             (string-lessp (upcase (car x))
                                           (upcase (car y)))
                           (nth 0 (cdr x)))))
                    (function
                     (lambda (x y)
                       (if (equal (nth 0 (cdr y))
                                  (nth 0 (cdr x)))
                           (string-lessp (car x)
                                         (car y))
                         (nth 0 (cdr x)))))
                    )))))
    )

  (if (memq ?r switches)                ; reverse sort order
      (setq file-alist (nreverse file-alist)))
  file-alist)
