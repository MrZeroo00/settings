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
(defvar run-cygwin ; treat cygwin as unix group
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

;;;; get hostname
(setq hostname
      (car (split-string
	    (downcase
	     ;;(cond ((getenv "HOSTNAME"))
		   ;;((getenv "HOST"))
		   ;;((getenv "COMPUTERNAME"))
		   ;;(t "default")))
       (system-name))
	    "\\.")))


;;;; add argument to load-path
(defun add-to-load-path-recompile (dir)
  (add-to-list 'load-path dir)
  (let (save-abbrevs) (byte-recompile-directory dir)))
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-load-path-recompile path))
        (mapcar 'expand-file-name paths)))

;;;; add conf and elisp to load-path
(add-to-load-path "~/.emacs.d/elisp"
		  "~/.emacs.d/macro"
		  "~/.emacs.d/conf")

;;;; add additional load-path
(if (file-exists-p "~/local/share/emacs/site-lisp/subdirs.el")
    (let ((dir (expand-file-name "~/local/share/emacs/site-lisp")))
      (if (member dir load-path) nil
	(setq load-path (cons dir load-path))
	(let ((default-directory dir))
	  (load (expand-file-name "subdirs.el") t t t)))))


;;;; byte-compile
(define-minor-mode auto-async-byte-compile-mode
  "With no argument, toggles the mode.
With a numeric argument, turn mode on iff ARG is positive."
  nil "" nil
  (if auto-async-byte-compile-mode
      (add-hook 'after-save-hook 'auto-async-byte-compile nil 'local)
    (remove-hook 'after-save-hook 'auto-async-byte-compile 'local)))

(defun auto-async-byte-compile ()
  (interactive)
  (and buffer-file-name
       (string-match "¥¥.el$" buffer-file-name)
       (executable-interpret (format "emacs_byte-compile %s" buffer-file-name))))
(add-hook 'emacs-lisp-mode-hook 'auto-async-byte-compile)

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

(defcustom my-disabled-features nil
  "The list of disabled features")
'(defmacro my-require-and-when (feature &rest body)
  (declare (indent 1))
  `(if (require ,feature nil t)
       (progn
         (message "Require success: %s" ,feature)
         ,@body)
     (message "Require error: %s" ,feature)))
(defmacro my-require-and-when (feature &rest body)
  (declare (indent 1))
  `(cond ((member ,feature my-disabled-features)
	  (message "Require skip: %s" ,feature))
	 ((require ,feature nil t)
	  (message "Require success: %s" ,feature)
	  ,@body)
	 (t
	  (message "Require error: %s" ,feature))))

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

(defcustom my-profiling nil
  "The flag to enable profiling")
(defmacro my-add-hook (hook function &optional append local)
  (declare (indent 4))
  `(add-hook ,hook
             (let ((func ,function))
               (if my-profiling
                   (lambda ()
                     (message "%s" func)
                     (profile func))
                 func))))


;;;; local settings
(my-load-and-when "00_local")
(my-load-and-when (concat "00_local_" hostname))


;;;; common settings
(my-load-and-when "00_init")
(my-load-and-when "01_modeline")
(my-load-and-when "01_util")
(my-load-and-when "05_server")
(my-load-and-when "40_coding")
(my-load-and-when "40_etc")
(my-load-and-when "40_key-bind")
(my-load-and-when "40_network")
(my-load-and-when "50_backup")
(my-load-and-when "50_buffer")
(my-load-and-when "50_complete")
(my-load-and-when "50_dired")
(my-load-and-when "50_file")
(my-load-and-when "50_find")
(my-load-and-when "50_minibuffer")
(my-load-and-when "50_occur")
(my-load-and-when "50_shell")
(my-load-and-when "50_spell")
(my-load-and-when "50_vcs")
(my-load-and-when "50_window")
(my-load-and-when "60_change-mode")
(my-load-and-when "60_dmacro")
(my-load-and-when "60_doc-view")
;;;(my-load-and-when "60_emms")
(my-load-and-when "60_hatena")
(my-load-and-when "60_howm")
;;;(my-load-and-when "60_iswitchb")
(my-load-and-when "60_key-chord")
(my-load-and-when "60_lookup")
(my-load-and-when "60_mew")
(my-load-and-when "60_migemo")
;;;(my-load-and-when "60_mmm-mode")
(my-load-and-when "60_one-key")
(my-load-and-when "60_org-mode")
(my-load-and-when "60_pukiwiki")
(my-load-and-when "60_view")
(my-load-and-when "60_w3m")
(my-load-and-when "60_woman")
(my-load-and-when "70_actionscript")
(my-load-and-when "70_c")
(my-load-and-when "70_cplusplus")
(my-load-and-when "70_css")
(my-load-and-when "70_emacs-lisp")
(my-load-and-when "70_haskell")
(my-load-and-when "70_html")
(my-load-and-when "70_javascript")
(my-load-and-when "70_lisp")
(my-load-and-when "70_objective-c")
(my-load-and-when "70_perl")
(my-load-and-when "70_python")
(my-load-and-when "70_ruby")
(my-load-and-when "70_scheme")
(my-load-and-when "70_shell")
(my-load-and-when "70_systemtap")
(my-load-and-when "70_text")
(my-load-and-when "70_xml")
(my-load-and-when "70_yaml")
(my-load-and-when "99_anything")
(my-load-and-when "99_hook")


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

(my-load-and-when "99_local")


;;;(if (y-or-n-p-with-timeout "My-Load-And-When timeout?" 5 nil)
;;;    (my-load-and-when "99_timeout"))

(setq debug-on-error t)
