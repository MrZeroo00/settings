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
                  "~/.emacs.d/conf")

;; define eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
(defmacro eval-safe (&rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

(load "00_init")
(load "01_util")
(load "01_modeline")
(load "40_etc")
(load "50_abbrev")
(load "50_c")
(load "50_gtags")
(load "50_howm")
(load "50_javascript")
(load "50_moccur-edit")
(load "50_occur")
;(load "50_org-mode")
(load "50_perl")
(load "50_pukiwiki")
;(load "50_w3m")
(load "50_wdired")
(load "60_ac-mode")
;(load "60_auto-save")
(load "60_auto-complete")
(load "60_backup")
(load "60_doc-view")
(load "60_dmacro")
(load "60_flymake")
;(load "60_gnuserv")
(load "60_hs-miner-mode")
(load "60_iswitchb")
(load "60_key-chord")
(load "60_linum")
(load "60_mcomplete")
(load "60_multiverse")
(load "60_template")
(load "60_uniquify")
(load "60_view")
(load "60_windows")
(load "99_anything")

(if (file-exists-p "~/.emacs.d/conf/99_local.el")
    (load "99_local"))
