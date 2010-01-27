;; check Operating System
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
(defvar run-cygwin ;; treat cygwin as unix group
  (equal system-type 'cygwin))

(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
	   (equal system-type 'ms-dos))))
(defvar run-darwin (equal system-type 'darwin))

;; check Emacsen major version
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


;; add argument to load-path
(defun add-to-load-path-recompile (dir)
  (add-to-list 'load-path dir)
  (let (save-abbrevs) (byte-recompile-directory dir)))
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-load-path-recompile path))
        (mapcar 'expand-file-name paths)))

;; add conf and elisp to load-path
(add-to-load-path "~/.emacs.d/elisp"
		  "~/.emacs.d/macro"
		  "~/.emacs.d/conf")

;; add additional load-path
(if (file-exists-p "~/local/share/emacs/site-lisp/subdirs.el")
    (let ((dir (expand-file-name "~/local/share/emacs/site-lisp")))
      (if (member dir load-path) nil
	(setq load-path (cons dir load-path))
	(let ((default-directory dir))
	  (load (expand-file-name "subdirs.el") t t t)))))


;; byte-compile
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
       (executable-interpret (format "byte-compile %s" buffer-file-name))))
(add-hook 'emacs-lisp-mode-hook 'auto-async-byte-compile)

;; define eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

;; define require and autoload, load
(defun autoload-if-found (function file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (and (locate-library file)
       (autoload function file docstring interactive type)))

(defmacro my-require-and-when (feature &rest body)
  (declare (indent 1))
  `(if (require ,feature nil t)
       (progn
         (message "Require success: %s" ,feature)
         ,@body)
     (message "Require error: %s" ,feature)))

(defmacro my-load-and-when (name &rest body)
  (declare (indent 1))
  `(if (load ,name t)
       (progn
         (message "Load success: %s" ,name)
         ,@body)
     (message "Load error: %s" ,name)))


(load "00_init")
(load "01_util")
(load "01_modeline")
(load "05_server")
(load "40_coding")
(load "40_key-bind")
(load "40_network")
(load "40_etc")
(load "50_backup")
(load "50_buffer")
(load "50_complete")
(load "50_dired")
(load "50_file")
(load "50_find")
(load "50_minibuffer")
(load "50_occur")
(load "50_shell")
(load "50_spell")
(load "50_vcs")
(load "50_window")
(load "60_change-mode")
(load "60_dmacro")
(load "60_doc-view")
(load "60_emms")
(load "60_hatena")
;(load "60_howm")
;(load "60_iswitchb")
(load "60_key-chord")
(load "60_lookup")
(load "60_woman")
(load "60_mew")
(load "60_migemo")
(load "60_mmm-mode")
(load "60_one-key")
(load "60_org-mode")
(load "60_pukiwiki")
(load "60_view")
(load "60_w3m")
(load "70_actionscript")
(load "70_c")
(load "70_cplusplus")
(load "70_css")
(load "70_emacs-lisp")
(load "70_haskell")
(load "70_html")
(load "70_javascript")
(load "70_lisp")
(load "70_objective-c")
(load "70_perl")
(load "70_python")
(load "70_ruby")
(load "70_scheme")
(load "70_shell")
(load "70_systemtap")
(load "70_text")
(load "70_xml")
(load "70_yaml")
(load "99_anything")
(load "99_hook")


;; local settings
(when run-linux
  (progn
    (if (file-exists-p "~/.emacs.d/conf/99_local_linux.el")
	(load "99_local_linux"))))

(when run-darwin
  (progn
    (add-to-list 'exec-path "/opt/local/bin")
    (if (file-exists-p "~/.emacs.d/conf/99_local_darwin.el")
	(load "99_local_darwin"))))

(when (and run-w32 run-meadow)
  (progn
    (if (file-exists-p "~/.emacs.d/conf/99_local_meadow.el")
	(load "99_local_meadow"))))

(if (file-exists-p "~/.emacs.d/conf/99_local.el")
    (load "99_local"))


;(if (y-or-n-p-with-timeout "Load timeout?" 5 nil)
;    (load "99_timeout"))

(setq debug-on-error nil)
