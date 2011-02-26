;;;; linum (show line number)
'(my-require-and-when 'linum
  (global-linum-mode t)
  (unless window-system
    ;; http://www.emacswiki.org/emacs/LineNumbers
    (setq linum-format
          (lambda (line)
            (propertize
             (format (let ((w (length
                               (number-to-string
                                (count-lines (point-min) (point-max))))))
                       (concat "%" (number-to-string w) "d "))
                     line)
             'face 'linum))))
  (set-face-foreground 'linum "brightblue")
  (set-face-background 'linum "brightblack")
  )


;;;; hs-minor-mode (fold code block)
(my-require-and-when 'hideshow
  (setq hs-hide-comments nil)
  ;;(setq hs-hide-comments-when-hiding-all nil)
  (setq hs-isearch-open 't)
  (my-load-and-when "_hs-hide-all-comments"))


;;;; align (align code)
(my-require-and-when 'align)


;;;; template (insert template code)
(my-require-and-when 'autoinsert
  (setq auto-insert-directory "~/.emacs.d/template/")
  (setq auto-insert-query nil)
  (setq auto-insert-alist
        (nconc '(
                 ;;("\\.c$" . ["template.c" my-template])
                 ("\\.sh$" . ["template.sh"
                              (lambda() (my-template-exec "/bin/sh"))
                              my-template])
                 ;;("\\.rb$" . ["template.sh"
                 ;;             (lambda() (my-template-exec "/usr/bin/ruby"))
                 ;;             my-template]))
                 ("bug.*\\.org$" . ["template_bug.org" my-template])
                 ) auto-insert-alist))

  (my-require-and-when 'cl
    (defvar template-replacements-alists
      '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
        ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
        ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

    (defmacro defreplace (name replace-string)
      `(defun ,name (str)
         (goto-char (point-min))
         (replace-string ,replace-string str)))

    (defreplace my-template-exec "%exec%")
    (defreplace my-template-package "%package%")

    (defun my-template ()
      (time-stamp)
      (mapc #'(lambda(c)
                (progn
                  (goto-char (point-min))
                  (replace-string (car c) (funcall (cdr c)) nil)))
            template-replacements-alists)
      (goto-char (point-max))
      (message "done.")))

  (add-hook 'find-file-not-found-hooks 'auto-insert))
