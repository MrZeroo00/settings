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
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
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

;; define eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(if (file-exists-p "~/.emacs.d/conf/00_local.el")
    (load "00_local"))

(load "00_init")
(load "01_util")
(load "01_modeline")
(load "05_server")
(load "40_coding")
(load "40_network")
(load "40_etc")
(load "50_buffer")
(load "50_complete")
(load "50_dired")
(load "50_file")
(load "50_hatena")
(load "50_howm")
(load "50_mmm-mode")
(load "50_occur")
(load "50_outline")
(load "50_pukiwiki")
(load "50_shell")
(load "50_w3m")
(load "60_backup")
(load "60_dmacro")
(load "60_doc-view")
(load "60_howm")
(load "60_iswitchb")
(load "60_key-chord")
(load "60_lookup")
(load "60_man")
(load "60_migemo")
(load "60_spell")
(load "60_vcs")
(load "60_view")
(load "60_window")
(load "70_actionscript")
(load "70_c")
(load "70_emacs-lisp")
(load "70_haskell")
(load "70_javascript")
(load "70_lisp")
(load "70_perl")
(load "70_python")
(load "70_ruby")
(load "70_scheme")
(load "70_systemtap")
(load "70_text")
(load "70_xml")
(load "70_yaml")
(load "99_anything")
(load "99_hook")

(when (and run-w32 run-meadow)
  (load "99_meadow"))

(if (file-exists-p "~/.emacs.d/conf/99_local.el")
    (load "99_local"))

;(if (y-or-n-p-with-timeout "Load timeout?" 5 nil)
;    (load "99_timeout"))