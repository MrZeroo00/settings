'(setq debug-on-error t)
(server-start)


;;;; ELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;;; measure time for tuning
;;;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?Meadow%2F%B5%AF%C6%B0%C2%AE%C5%D9
(defconst my-time-zero (current-time))
(defvar my-time-list nil)

(defun my-time-lag-calc (lag label)
  (if (assoc label my-time-list)
      (setcdr (assoc label my-time-list)
              (- lag (cdr (assoc label my-time-list))))
    (setq my-time-list (cons (cons label lag) my-time-list))))

(defun my-time-lag (label)
  (let* ((now (current-time))
         (min (- (car now) (car my-time-zero)))
         (sec (- (car (cdr now)) (car (cdr my-time-zero))))
         (msec (/ (- (car (cdr (cdr now)))
                     (car (cdr (cdr my-time-zero))))
                  1000))
         (lag (+ (* 60000 min) (* 1000 sec) msec)))
    (my-time-lag-calc lag label)))

(defun my-time-lag-print ()
  (message (prin1-to-string
            (sort my-time-list
                  (lambda (x y) (> (cdr x) (cdr y)))))))
(my-time-lag "total")
(add-hook 'after-init-hook
          (lambda () (my-time-lag "total")
            (my-time-lag-print)
            ;;(ad-disable-regexp 'require-time)
            (switch-to-buffer
             (get-buffer "*Messages*"))
            ) t)
(my-time-lag "all")

'(defadvice require
   (around require-time activate)
   (my-time-lag (format "require-%s"
                        (ad-get-arg 0)))
   ad-do-it
   (my-time-lag (format "require-%s"
                        (ad-get-arg 0)))
   )


;;;; check Operating System
(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (or (equal system-type 'usg-unix-v)
          (or  (equal system-type 'berkeley-unix)
               (equal system-type 'cygwin)))))

(defvar run-linux
  (equal system-type 'gnu/linux))
(defvar run-system-v
  (equal system-type 'usg-unix-v))
(defvar run-bsd
  (equal system-type 'berkeley-unix))
(defvar run-cygwin                      ; treat cygwin as unix group
  (equal system-type 'cygwin))

(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;;;; check Emacsen major version
(defvar run-emacs20
  (and (equal emacs-major-version 20)
       (null (featurep 'xemacs))))
(defvar run-emacs21
  (and (equal emacs-major-version 21)
       (null (featurep 'xemacs))))
(defvar run-emacs22
  (and (equal emacs-major-version 22)
       (null (featurep 'xemacs))))
(defvar run-meadow (featurep 'meadow))
(defvar run-meadow1 (and run-meadow run-emacs20))
(defvar run-meadow2 (and run-meadow run-emacs21))
(defvar run-meadow3 (and run-meadow run-emacs22))
(defvar run-xemacs (featurep 'xemacs))
(defvar run-xemacs-no-mule
  (and run-xemacs (not (featurep 'mule))))
(defvar run-carbon-emacs(and run-darwin window-system))

;;;; dummy string-match-p
(unless (fboundp 'string-match-p)
  (defun string-match-p (regexp string &optional start)
    "Same as `string-match' except this function does not
change the match data."
    (let ((inhibit-changing-match-data t))
      (string-match regexp string start))))

;;;; get hostname
(eval-when-compile
  (defvar hostname
    (car (split-string
          (downcase
           ;;(cond ((getenv "HOSTNAME"))
           ;;((getenv "HOST"))
           ;;((getenv "COMPUTERNAME"))
           ;;(t "default")))
           (system-name))
          "\\."))))


;;;; add argument to load-path
(defun add-to-load-path-recompile (dir)
  (add-to-list 'load-path dir)
  (let (save-abbrevs) (byte-recompile-directory dir)))
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-load-path-recompile path))
        (mapcar 'expand-file-name paths)))

;;;; add conf and macro to load-path
(add-to-load-path "~/.emacs.d/conf"
                  "~/.emacs.d/macro")

(if (file-exists-p "~/.emacs.d/elisp/subdirs.el")
    (let ((dir (expand-file-name "~/.emacs.d/elisp")))
      (if (member dir load-path) nil
        (setq load-path (cons dir load-path))
        (let ((default-directory dir))
          (load (expand-file-name "subdirs.el") t t t)))))

;;;; add additional load-path
(if (file-exists-p "~/local/share/emacs/site-lisp/subdirs.el")
    (let ((dir (expand-file-name "~/local/share/emacs/site-lisp")))
      (if (member dir load-path) nil
        (setq load-path (cons dir load-path))
        (let ((default-directory dir))
          (load (expand-file-name "subdirs.el") t t t)))))


;;;; define eval-safe
;;;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

;;;; define my-eval-after-load
(defmacro my-eval-after-load (file &rest args)
  `(eval-after-load ,file
     (quote (progn ,@args))))
(put 'my-eval-after-load 'lisp-indent-function 1)

;;;; define require and autoload, load
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))

(eval-when-compile
  (defvar my-disabled-features '()
    "The list of disabled features"))
'(defmacro my-require-and-when (feature &rest body)
   (declare (indent 1))
   `(if (require ,feature nil t)
        (progn
          (message "Require success: %s" ,feature)
          ,@body)
      (message "Require error: %s" ,feature)))
(defmacro my-require-and-when (feature &rest body)
  (declare (indent 1))
  ;;`(unless (featurep ,feature)
  ;;   (cond ((member ,feature my-disabled-features)
  `(unless (featurep ,feature)
     (progn
       (if (and (not (package-built-in-p ,feature))
                (assq ,feature package-archive-contents)
                (not (package-installed-p ,feature)))
           (progn
             (message "Package install: %s" ,feature)
             (package-install ,feature)))
       (cond ((member ,feature my-disabled-features)
              (message "Require skip: %s" ,feature))
             ((require ,feature nil t)
              (message "Require success: %s" ,feature)
              ,@body)
             (t
              (message "Require error: %s" ,feature))))))

'(defmacro my-autoload-and-when (function file &rest body)
   (declare (indent 2))
   `(if (autoload-if-found ,function ,file nil t)
        (progn
          (message "Autoload success: %s %s" ,function ,file)
          (my-eval-after-load ,file ,@body))
      (message "Autoload error: %s %s" ,function ,file)))
(defmacro my-autoload-and-when (function file &rest body)
  (declare (indent 2))
  `(cond ((member ,file my-disabled-features)
          (message "Autoload skip: %s %s" ,function ,file))
         ((autoload-if-found ,function ,file nil t)
          (message "Autoload success: %s %s" ,function ,file)
          (my-eval-after-load ,file ,@body))
         (t
          (message "Autoload error: %s %s" ,function ,file))))

'(defmacro my-load-and-when (name &rest body)
   (declare (indent 1))
   `(if (load ,name t)
        (progn
          (message "Load success: %s" ,name)
          ,@body)
      (message "Load error: %s" ,name)))
(defmacro my-load-and-when (name &rest body)
  (declare (indent 1))
  `(cond ((member ,name my-disabled-features)
          (message "Load skip: %s" ,name))
         ((load ,name t)
          (message "Load success: %s" ,name)
          ,@body)
         (t
          (message "Load error: %s" ,name))))

(my-require-and-when 'cl
  (defun profile (block)
    (labels ((timediff (s e)
                       (destructuring-bind (h1 l1 m1) s
                         (destructuring-bind (h2 l2 m2) e
                           (+ (* 65536 (- h2 h1)) (- l2 l1) (* 0.000001 (- m2 m1)))))))
      (let ((s-time (current-time)) e-time)
        (funcall block)
        (setq e-time (current-time))
        (message "%s secs" (timediff s-time e-time))))))

(my-load-and-when "_which")

;;;; boot check
;;;(install-elisp-from-emacswiki "emacs-init-check")
(my-require-and-when 'emacs-init-check
  (setq auto-emacs-init-check-file-regexp "/\\.emacs\\.d/")
  ;;(add-to-list 'auto-emacs-init-check-program-args "nice")
  (add-hook 'vc-checkin-hook 'auto-emacs-init-check))

;;;; byte-compile
;;;(install-elisp-from-emacswiki "auto-async-byte-compile")
(my-require-and-when 'auto-async-byte-compile
  (setq auto-async-byte-compile-exclude-files-regexp "/\\.emacs\\.d/conf/")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))

;;;; profiling
(eval-when-compile
  (defvar my-profiling nil
    "The flag to enable profiling"))
;;;; hook profiling macro (still unstable)
(defmacro my-add-hook (hook function &optional append local)
  (declare (indent 4))
  `(add-hook ,hook
             (let ((func ,function))
               (if my-profiling
                   (lambda ()
                     (message "%s" func)
                     (profile func))
                 func))
             ,append ,local))


;;;; local settings
(my-load-and-when (concat "00_local_" hostname))

(when run-linux
  (my-load-and-when "00_local_linux"))

(when run-darwin
  (add-to-list 'exec-path "/opt/local/bin")
  (my-load-and-when "00_local_darwin"))

(when (and run-w32)
  (my-load-and-when "00_local_windows"))

(when (and run-w32 run-meadow)
  (my-load-and-when "00_local_meadow"))


;;;; common settings
(setq my-disabled-features
	  (append '("60_change-mode"
				"60_doc-view"
				"60_key-chord"
				"60_mmm-mode"
				"60_one-key"
				"60_view"
				)
			  my-disabled-features))

(mapc (lambda (fname)
        (if (and (string-match "^[0-9][0-9]_[^.]+\.el$" fname)
                 (not (string-match "^[0-9][0-9]_local_[^.]+\.el$" fname)))
            (my-load-and-when (substring fname 0 -3))))
      (directory-files (expand-file-name "~/.emacs.d/conf")))


;;;; local settings
(when run-linux
  (my-load-and-when "99_local_linux"))

(when run-darwin
  (add-to-list 'exec-path "/opt/local/bin")
  (my-load-and-when "99_local_darwin"))

(when (and run-w32)
  (my-load-and-when "99_local_windows"))

(when (and run-w32 run-meadow)
  (my-load-and-when "99_local_meadow"))

(my-load-and-when (concat "99_local_" hostname))


'(if (y-or-n-p-with-timeout "My-Load-And-When timeout?" 5 nil)
	 (my-load-and-when "99_timeout"))

;;;; for profiling
(defun load-test (txt counter)
  "create a new buffer, insert txt"
  (pop-to-buffer (get-buffer-create (generate-new-buffer-name "load-test")))
  (while (> counter 0)
    (insert txt)
    (setq counter (1- counter))))

(my-time-lag "all")


'(setq debug-on-error t)
