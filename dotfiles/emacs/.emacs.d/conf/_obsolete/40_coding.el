;;;(install-elisp "http://www.loveshack.ukfsn.org/emacs/indent-tabs-maybe.el")
;(my-require-and-when 'indent-tabs-maybe)


;;;; emphasize Space/Tab/Newline
;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=visualize%20tab
;;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
;;;(defface my-face-b-1 '((t (:background "gray"))) nil)
;;;(defface my-face-b-2 '((t (:background "gray26"))) nil)
;;;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;;(defvar my-face-r-1 'my-face-r-1)
;;;(defvar my-face-b-1 'my-face-b-1)
;;;(defvar my-face-b-2 'my-face-b-2)
;;;(defvar my-face-u-1 'my-face-u-1)
;;;
;;;(defadvice font-lock-mode (before my-font-lock-mode ())
;;;  (font-lock-add-keywords
;;;   major-mode
;;;   '(("\t" 0 my-face-b-2 append)
;;;     ("　" 0 my-face-b-1 append)
;;;     ("[ \t]+$" 0 my-face-u-1 append)
;;;     ;;("[\r]*\n" 0 my-face-r-1 append)
;;;     )))
;;;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;;;(ad-activate 'font-lock-mode)


;;;; xcscope
;;;; http://cscope.sourceforge.net/
;;;(my-require-and-when 'xcscope)


;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=tagsfile%20maker
'(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))


;;;; mode-info
;;;; http://www.namazu.org/~tsuchiya/elisp/mode-info.html
'(my-require-and-when 'mi-config
;;;  (define-key global-map "\C-hf" 'mode-info-describe-function)
;;;  (define-key global-map "\C-hv" 'mode-info-describe-variable)
;;;  (define-key global-map "\M-." 'mode-info-find-tag)
  (my-require-and-when 'mi-fontify)
  (setq mode-info-index-directory "~/.emacs.d")
  (setq mode-info-class-alist
  '((elisp  emacs-lisp-mode lisp-interaction-mode)
    (libc   c-mode c++-mode)
    (make   makefile-mode)
    (perl   perl-mode cperl-mode eperl-mode)
    (ruby   ruby-mode)
    (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode))))


;;;; to pop up compilation buffers at the bottom
'(my-eval-after-load "split-root"
  (my-require-and-when 'compile)
  (defvar my-compilation-window nil
    "The window opened for displaying a compilation buffer.")

  (setq my-compilation-window-height 14)

  (defun my-display-buffer (buffer &optional not-this-window)
    (if (or (compilation-buffer-p buffer)
      (equal (buffer-name buffer) "*Shell Command Output*"))
  (progn
    (unless (and my-compilation-window (window-live-p my-compilation-window))
      (setq my-compilation-window (split-root-window my-compilation-window-height))
      (set-window-buffer my-compilation-window buffer))
    my-compilation-window)
      (let ((display-buffer-function nil))
  (display-buffer buffer not-this-window))))

  (setq display-buffer-function 'my-display-buffer)

  ;; on success, delete compilation window right away!
  (add-hook 'compilation-finish-functions
      (lambda(buf res)
         (unless (or (eq last-command 'grep)
  		   (eq last-command 'grep-find))
  	 (when (equal res "finished\n")
  	   (when my-compilation-window
  	     (delete-window my-compilation-window)
  	     (setq my-compilation-window nil))
  	   (message "compilation successful")))))
  )
