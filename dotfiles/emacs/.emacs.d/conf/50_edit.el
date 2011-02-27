;;;; region setting
(transient-mark-mode t)
'(setq highlight-nonselected-windows t)
'(pc-selection-mode)
'(delete-selection-mode t)
(setq shift-select-mode nil)

;;;; visible-mark
;;;(install-elisp-from-emacswiki "visible-mark.el")
(my-require-and-when 'visible-mark)


;;;; highlight current line
'(global-hl-line-mode)
'(hl-line-mode t)
;;;;;;(setq hl-line-face 'underline)
'(set-face-background 'hl-line "DarkOliveGreen")
;;;(install-elisp-from-emacswiki "col-highlight.el")
;;;(install-elisp-from-emacswiki "vline.el")
'(my-require-and-when 'col-highlight
   (column-highlight-mode t)
   ;;(toggle-highlight-column-when-idle t)
   ;;(col-highlight-set-interval 3)
   (custom-set-faces
    '(col-highlight ((t (:background "DarkOliveGreen"))))))
;;;(install-elisp-from-emacswiki "hl-line+.el")
;;;(install-elisp-from-emacswiki "crosshairs.el")
'(my-require-and-when 'crosshairs
   (crosshairs-mode))


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


;;;; stripes
;;;(install-elisp-from-emacswiki "stripes.el")
'(my-require-and-when 'stripes
  (set-face-background 'stripes-face "gray"))


;;;; share clipboard
(defvar prev-yanked-text nil "*previous yanked text")

(setq interprogram-cut-function
      (lambda (text &optional push)
        ;; use pipe
        (let ((process-connection-type nil))
          (let ((proc (start-process "cbcopy" nil "cbcopy")))
            (process-send-string proc string)
            (process-send-eof proc)
            ))))

(when run-darwin
  (setq interprogram-paste-function
        (lambda ()
          (let ((text (shell-command-to-string "cbpaste")))
            (if (string= prev-yanked-text text)
                nil
              (setq prev-yanked-text text))))))


;;;; kill-summary
;;;(install-elisp "http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el")
(my-autoload-and-when 'kill-summary "kill-summary"
  (global-set-key "\M-y" 'kill-summary))


;;;; list-register
;;;(install-elisp "http://www.bookshelf.jp/elc/list-register.el")
(my-require-and-when 'list-register)


;;;; thing-opt
(my-require-and-when 'thingatpt)
;;;(install-elisp-from-emacswiki "thing-opt.el")
(my-require-and-when 'thing-opt)


;;;; cua-mode
(cua-mode t)
(setq cua-auto-tabify-rectangles nil)
'(setq cua-keep-region-after-copy t)
(setq cua-enable-cua-keys nil)


;;;; wrap-region
;;;(install-elisp "https://github.com/rejeep/wrap-region/raw/master/wrap-region.el")
(my-require-and-when 'wrap-region
  (wrap-region-global-mode t)
  ;;(add-to-list 'wrap-region-tag-active-modes 'some-tag-mode)
  ;;(add-to-list 'wrap-region-except-modes 'conflicting-mode)
  )


;;;; align (align code)
(my-require-and-when 'align)


;;;; autoinsert (insert template code)
;;; (install-elisp "http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/autoinsert.el")
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


;;;; keisen-mule
;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=keisen
'(if window-system
    (my-autoload-and-when 'keisen-mode "keisen-mouse")
  (my-autoload-and-when 'keisen-mode "keisen-mule"))


;;;; enriched-mode
'(my-require-and-when 'enriched)


;;;; macros
'(my-load-and-when "_copy-region-with-info")
'(my-load-and-when "_duplicate-line"
  (define-key esc-map "Y" 'duplicate-line))
(my-load-and-when "_screen-read-hardcopy")
