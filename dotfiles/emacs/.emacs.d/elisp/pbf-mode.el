;; pbf-mode.el --- Associate a buffer with the project.

;; Copyright (C) 2000-2002  Keiichi Suzuki

;; Author: Keiichi Suzuki <keiichi@nanap.org>
;;	TSUCHIYA Masatoshi <tsuchiya@pine.kuee.kyoto-u.ac.jp>
;; Keywords: Programing, Project
;; Version: 0.7

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License any
;; later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
  
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;;; Commentary:

;; For programed use of associate a buffer with the project.

;;; Install:

;; Install this file to appropriate directory with associated by load-path.
;; And put these lines into your ~/.emacs.

;;	(require 'pbf-mode)
;;	(pbf-setup)
;;	(pbf-mode t)

;; And create project definition file `~/.pbf.el[c]'.

;; Sample for .pbf.el

;;	(pbf-project HOME nil
;;	  "My private."
;;	  :directory (expand-file-name "~/"))

;; And find any file in the your home directory.

;;; History:

;; Mar 19 2002	Version 0.7 released.
;; Add `:cvs-update-directory' for `pcl-cvs'.
;; Do not check file-coding-system when specified coding system with file
;; variable. (by TSUCHIYA-san)

;; Apr 21 2001	Version 0.6.1 released.
;; Invalid timing to set `post-command-hook', fix.

;; Apr 12 2001	Version 0.6 released.
;; Add `:add-log-time-format' for `add-log'. (by TSUCHIYA-san)
;; Can use on Emacs 19.34. (by TSUCHIYA-san)

;; Mar 31 2001	Version 0.5 released.
;; Now, we can control ChangeLog mode.
;; Modify buffer name format on mode line.

;; Jan 26 2001	Version 0.4.2 released.
;; Could not check file coding system, if `buffer-file-coding-system' is
;; `undecided', fix.

;; Jan 15 2001	Version 0.4.1 released.
;; Could not change c-style, fix.

;; Dec 14 2000	Version 0.4 released.
;;	New implementation.

;; Dec 05 2000	Version 0.3 released.
;; Nov 28 2000	Version 0.2 released.
;; Nov 24 2000	Version 0.1 released.

;;; Code:

(eval-when-compile
  (require 'cl)
  (require 'dired)
  (require 'rcompile))
(autoload 'ange-ftp-ftp-name "ange-ftp")

(eval-and-compile
  (condition-case nil
      :symbol-for-testing-whether-colon-keyword-is-available-or-not
    (void-variable
     (eval '(defconst :display-name ':display-name))
     (eval '(defconst :directory ':directory))
     (eval '(defconst :remote ':remote))
     (eval '(defconst :inhibit-subdirectory ':inhibit-subdirectory))
     (eval '(defconst :file-encoding ':file-encoding))
     (eval '(defconst :c-style ':c-style))
     (eval '(defconst :add-log-directory ':add-log-directory))
     (eval '(defconst :add-log-file-name ':add-log-file-name))
     (eval '(defconst :add-log-full-name ':add-log-full-name))
     (eval '(defconst :add-log-mailing-address ':add-log-mailing-address))
     (eval '(defconst :add-log-time-format ':add-log-time-format))
     (eval '(defconst :mail-to ':mail-to))
     (eval '(defconst :mail-project-name ':mail-project-name)))))

(defvar pbf-use-at-form t
  "*Use buffer name fortmat as FILE-NAME@PROJECT-NAME")

(defvar pbf-config-file-name "~/.pbf"
  "*Configuration file name of `pbf-mode'.")

(defvar pbf-mode-prefix-key "\C-c/"
  "*Prefix for keymap `pbf-prefix-map'.
After change this value, call function `pbf-setup'.")

(defvar pbf-mode nil
  "Non-nil if in project buffer global minor mode.
See also function `pbf-mode'.")

(defvar pbf-mode-map nil
  "Keymap for `pbf-mode'.")

(defvar pbf-project-name-separator "/")

(defvar pbf-mode-independ-hook
  '(pbf-set-file-encoding)
  "A hook called after a buffer associate to the project.
This variable has initial value.
See also variable `pbf-mode-depend-hook-alist'.")

(defconst pbf-hook-alist
  '((c-mode-common-hook pbf-c-mode-set-style)
    (change-log-mode-hook pbf-change-log-mode-set-style)
    (dired-mode-hook pbf-setup-buffer)))

(defvar pbf-root-regexp "\\`\\([/~]\\|[a-z]:\\)")
(defvar pbf-project-obarray (make-vector 7 0)
  "Obarray of projects.")
(defvar pbf-template-obarray (make-vector 7 0)
  "Obarray of project templates.")
(defvar pbf-project-name-prefix nil)
(defvar pbf-parent-project nil)
(defvar pbf-buffer-project nil)
(put 'pbf-buffer-project 'permanent-local t)
(defvar pbf-mode-line-buffer-identification-original nil)
(defvar pbf-buffer-name nil)
(defvar pbf-buffer-list nil)

;;;###autoload
(defmacro pbf-template (symbol &rest defs)
  "Define a project template of `pbf-mode'.

Project template is temlate of real project.  When real project uses a
temlate, the project is defined based on the template.

See function `pbf-project' for meaning of each arguments."
  (let* ((doc-string (when (stringp (car defs))
		       (prog1 (car defs)
			 (pop defs)))))
    `(let ((pbf-parent-project
	    (pbf-template-internal
	     ,(symbol-name symbol)
	     ,doc-string
	     ,@(let (def rest)
		 (while (and defs (symbolp (setq def (car defs))))
		   (setq defs (cdr defs)
			 rest (cons (pop defs) (cons `(quote ,def) rest))))
		 (nreverse rest)))))
       ,@(when defs
	   (let (def rest)
	     (while defs
	       (unless (consp (setq def (pop defs)))
		 (error "Invalid sub-project %s." def))
	       (push (macroexpand `(pbf-template ,@def)) rest))
	     (nreverse rest))))))
(put 'pbf-template 'lisp-indent-function 1)

(defun pbf-template-internal (name doc-string &rest properties)
  (let (sym)
    (if pbf-parent-project
	(progn
	  (setq sym (intern (format "%s%s%s" (symbol-name
					      pbf-parent-project)
				    pbf-project-name-separator name)
			    pbf-template-obarray))
	  (put sym 'parent-project pbf-parent-project)
	  (set pbf-parent-project (cons sym (symbol-value
					     pbf-parent-project))))
      (setq sym (intern name pbf-template-obarray)))
    (put sym 'name name)
    (put sym 'pbf-documentation doc-string)
    (while properties
      (put sym (pop properties) (pop properties)))
    (set sym nil)
    sym))

;;;###autoload
(defmacro pbf-project (symbol template &rest defs)
  "Define a project of `pbf-mode'.

Define SYMBOL as a project.

ANCESTORS is list of ancestors or templates of this project.
All ancestors and templates must define before use.

If the 1st element of DEFS is string, it is used as document.
And rest arguments are project informations.  The each
infomation is a pair of keyword and value.  The `pbf-mode'
defined following keywords.

`:remote': String of ange-ftp prefix. (ex. `account@hostname')
`:directory': String of directory path.

`:display-name': String of project name for display.  Symbol
name of SYMBOL is used by default.
`:inhibit-subdirectory': Non-nil inhibits sub-direcroty name
under the project as display name.

`:file-encoding': Symbol of coding system for file encoding.
When save file, if buffer file coding system is same as
`default-buffer-file-coding-system' then modify coding system to
this after ask to user.

`:c-style': String of cc-mode supported language' style name.
See also function `c-set-style'.

And any more... As you like. :-)"
  (let* ((doc-string (when (stringp (car defs))
		       (prog1 (car defs)
			 (pop defs)))))
    `(let ((pbf-parent-project
	    (pbf-project-internal
	     ,(symbol-name symbol)
	     ,(and template (symbol-name template))
	     ,doc-string
	     ,@(let (def rest)
		 (while (and defs (symbolp (setq def (car defs))))
		   (setq defs (cdr defs)
			 rest (cons (pop defs) (cons `(quote ,def) rest))))
		 (nreverse rest)))))
       ,@(when defs
	   (let (def rest)
	     (while defs
	       (unless (consp (setq def (pop defs)))
		 (error "Invalid sub-project %s." def))
	       (push (macroexpand `(pbf-project ,@def)) rest))
	     (nreverse rest))))))
(put 'pbf-project 'lisp-indent-function 2)

(defun pbf-intern-project (name)
  (let (sym)
    (if pbf-parent-project
	(progn
	  (setq sym (intern (concat (symbol-name pbf-parent-project)
				    pbf-project-name-separator name)
			    pbf-project-obarray))
	  (put sym 'parent-project pbf-parent-project)
	  (put pbf-parent-project 'children
	       (cons sym (get pbf-parent-project 'children))))
      (setq sym (intern name pbf-project-obarray)))
    (put sym 'name name)
    sym))

(defun pbf-project-internal (name template doc-string &rest properties)
  (let ((sym (pbf-intern-project name)))
    (put sym 'name name)
    (put sym 'pbf-documentation doc-string)
    (while properties
      (put sym (pop properties) (pop properties)))
    (if template
	(pbf-project-internal-with-template
	 sym (or (intern-soft template pbf-template-obarray)
		 (error "%s: %s is undefined template."
			sym template)))
      (pbf-project-internal-no-template sym))
    sym))

(defun pbf-project-internal-with-template (me template)
  (when pbf-parent-project
    (pbf-inherit-properties me pbf-parent-project))
  (let ((mam template))
    (while mam
      (pbf-inherit-properties me mam t)
      (setq mam (get mam 'parent-project))))
  (set me (concat (pbf-expand-path me pbf-parent-project)))
  (when (symbol-value template)
    (let ((pbf-parent-project me))
      (pbf-project-internal-clone-template (symbol-value template)))))

(defun pbf-project-internal-clone-template (templates)
  (let (template child)
    (while templates
      (setq template (pop templates)
	    child (pbf-intern-project (get template 'name)))
      (pbf-inherit-properties child template t)
      (pbf-inherit-properties child pbf-parent-project)
      (set child (pbf-expand-path child pbf-parent-project))
      (when (symbol-value template)
	(let ((pbf-parent-project child))
	  (pbf-project-internal-clone-template (symbol-value template)))))))

(defun pbf-project-internal-no-template (me)
  (when pbf-parent-project
    (pbf-inherit-properties me pbf-parent-project))
  (set me (pbf-expand-path me pbf-parent-project)))

(defun pbf-expand-path (me mam)
  (let ((dir (get me :directory)))
    (when dir
      (setq dir (file-name-as-directory dir))
      (unless (string-match pbf-root-regexp dir)
	(let ((m mam))
	  (while (and m (null (symbol-value m)))
	    (setq m (get m 'parent-project)))
	  (setq dir (concat (symbol-value m) dir))))
      (let ((remote (get me :remote)))
	(if remote
	    (unless (and mam (equal remote (get mam :remote)))
	      (setq dir (concat "/" remote ":"
				(or (nth 2 (ange-ftp-ftp-name dir)) dir))))
	  (expand-file-name dir))))
    dir))

(defun pbf-inherit-properties (me mam &optional from-template)
  (let ((props (symbol-plist mam))
	prop val func)
    (while props
      (setq prop (pop props) val (pop props))
      (when val
	(setq func (get prop 'pbf-inherit-method))
	(cond
	 ((null func)
	  (unless (get me prop)
	    (put me prop val)))
	 ((eq func t)
	  ;; Do not inherit this property.
	  )
	 ((functionp func)
	  (funcall func me mam prop val from-template))
	 (t
	  ;; Others are undefined.
	  ))))))

(put 'children 'pbf-inherit-method t)
(put 'pbf-documentation 'pbf-inherit-method 'pbf-inherit-only-template)
(put :display-name 'pbf-inherit-method 'pbf-inherit-only-template)
(put :directory 'pbf-inherit-method 'pbf-inherit-only-template)
(put :inhibit-subdirectory 'pbf-inherit-method 'pbf-inherit-only-template)

(defun pbf-inherit-only-template (me mam prop val from-template)
  (when (and from-template (null (get me prop)))
    (put me prop val)))

(defun pbf-dump-obarray (obr)
  (mapatoms
   (lambda (x)
     (insert (symbol-name x) "\t" (format "%s" (symbol-value x)) "\n")
     (let ((plist (symbol-plist x)))
       (while plist
	 (if (car (cdr plist))
	     (insert (format "\t%s; %s\n" (pop plist) (pop plist)))
	   (setq plist (cdr (cdr plist)))))))
   obr))

;;;###autoload
(defun pbf-setup ()
  "Set up for using pbf-mode and load project definition file."
  (interactive)
  (pbf-setup-obarray)
  (or (assq 'pbf-mode minor-mode-alist)
      (setq minor-mode-alist
	    (cons '(pbf-mode " pbf") minor-mode-alist)))
  (unless (eq pbf-mode-prefix-key
	      (get 'pbf-mode-map 'pbf-mode-prefix-key))
    (define-prefix-command 'pbf-mode-map)
    (define-key pbf-mode-map (concat pbf-mode-prefix-key "r")
      'pbf-setup)
    (define-key pbf-mode-map (concat pbf-mode-prefix-key "b")
      'pbf-switch-to-buffer)
    (define-key pbf-mode-map (concat pbf-mode-prefix-key "\C-b")
      'pbf-list-buffers)
    (define-key pbf-mode-map (concat pbf-mode-prefix-key "m")
      'pbf-compose-mail)
    (define-key pbf-mode-map (concat pbf-mode-prefix-key "c")
      'pbf-compile)
    (put 'pbf-mode-map 'pbf-mode-prefix-key pbf-mode-prefix-key))
  (unless (assq 'pbf-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
	  (cons (cons 'pbf-mode 'pbf-mode-map) minor-mode-map-alist)))
  (let ((entries pbf-hook-alist)
	entry hook)
    (while entries
      (setq entry (pop entries)
	    hook (pop entry))
      (while entry
	(add-hook hook (pop entry)))))
  (let ((file (expand-file-name pbf-config-file-name))
	success)
    (unwind-protect
	(progn
	  (load pbf-config-file-name)
	  (setq success t))
      (unless success
	(pbf-setup-obarray))))
  (when pbf-mode
    (pbf-mode)
    (pbf-mode))
  (run-hooks 'pbf-setup-hook))

(defun pbf-setup-obarray ()
  (setq pbf-project-obarray (make-vector 7 0)
	pbf-template-obarray (make-vector 7 0)))

(defun pbf-mode (&optional arg)
  "`pbf-mode' is a global minor mode for associating Project and BuFfer.
This mode binds following key:
\\{pbf-mode-map}"
  (interactive "P")
  (if (setq pbf-mode (if (null arg)
			 (not pbf-mode)
		       (> (prefix-numeric-value arg) 0)))
      (let ((buffers (buffer-list)))
	(while buffers
	  (with-current-buffer (pop buffers)
	    (pbf-setup-buffer)))
	(add-hook 'change-major-mode-hook 'pbf-setup-buffer)
	(run-hooks 'pbf-mode-hook))
    (remove-hook 'change-major-mode-hook 'pbf-setup-buffer)))

(defun pbf-setup-buffer ()
  (when (set (make-local-variable 'pbf-buffer-project)
	     (if (eq major-mode 'dired-mode)
		 (and (stringp dired-directory)
		      (pbf-set-buffer-variables
		       (pbf-search-project-by-path dired-directory)))
	       (and (stringp buffer-file-name)
		    (pbf-set-buffer-variables
		     (pbf-search-project-by-path buffer-file-name)))))
    (add-hook 'post-command-hook 'pbf-post-command-hook)
    (push (current-buffer) pbf-buffer-list)
    (run-hooks 'pbf-mode-independ-hook)))

(defun pbf-post-command-hook ()
  (remove-hook 'post-command-hook 'pbf-post-command-hook)
  (let (buffer)
    (while pbf-buffer-list
      (when (buffer-live-p (setq buffer (pop pbf-buffer-list)))
	(with-current-buffer buffer
	  (pbf-set-buffer-variables pbf-buffer-project))))))


(defun pbf-set-buffer-variables (prj)
  (when prj
    (let ((short-name (let ((sub (cdr prj))
			    base)
			(if (or (eq major-mode 'dired-mode)
				(not (get (car prj) :inhibit-subdirectory))
				(progn
				  (setq base (file-name-nondirectory sub))
				  (string= sub base)))
			    sub
			  (concat ".../" base)))))
      (set (make-local-variable 'pbf-buffer-name)
	   (if pbf-use-at-form
	       (concat (file-name-nondirectory short-name) "@"
		       (pbf-display-name (car prj))
		       pbf-project-name-separator
		       (file-name-directory short-name))
	 (concat (pbf-display-name (car prj)) pbf-project-name-separator
		 short-name)))))
  (unless pbf-mode-line-buffer-identification-original
    (set (make-local-variable 'pbf-mode-line-buffer-identification-original)
	 mode-line-buffer-identification))
  (setq mode-line-buffer-identification
	`(pbf-mode (12 "" (pbf-buffer-project
			   pbf-buffer-name
			   ,pbf-mode-line-buffer-identification-original))
		   ,pbf-mode-line-buffer-identification-original))
  prj)

(defun pbf-search-project-by-path (path)
  (let ((path-len (length (file-name-directory path)))
	(match-len 0)
	match-sym str len)
    (mapatoms
     (lambda (X)
       (setq str (symbol-value X)
	     len (length str))
       (when (and (<= len path-len)
		  (> len match-len)
		  (string= (substring str 0 len)
			   (substring path 0 len)))
	 (setq match-sym X
	       match-len len)))
     pbf-project-obarray)
    (when match-sym
      (cons match-sym (substring path match-len)))))

(defun pbf-display-name (prj)
  (let (rest)
    (while prj
      (push (or (get prj :display-name) (get prj 'name)) rest)
      (setq prj (get prj 'parent-project)))
    (setq rest (delete "" rest))
    (mapconcat 'identity rest pbf-project-name-separator)))

(defmacro pbf-with-options (opts &rest body)
  (let ((tmp-val (make-symbol "tmp-val"))
	(prj (make-symbol "prj"))
	let-args opt predicate opt-sym)
    (while opts
      (setq opt (pop opts))
      (push `(,opt ,(if (setq opt-sym (intern (concat ":" (symbol-name opt)))
			      predicate (get opt-sym 'pbf-type-predicate))
			`(if (,predicate (setq ,tmp-val (get ,prj ,opt-sym)))
			     ,tmp-val
			   (eval ,tmp-val))
		      `(get ,prj ,opt-sym)))
	    let-args))
    `(when (and pbf-mode pbf-buffer-project)
       (let ((,prj (car pbf-buffer-project))
	     ,tmp-val)
	   (let ,let-args
	     ,@body)))))
(put 'pbf-with-options 'lisp-indent-function 1)
(def-edebug-spec pbf-with-options
  (sexp body))

(defun pbf-buffer-project (&optional buffer)
  (if buffer
      (with-current-buffer buffer
	pbf-buffer-project)
    pbf-buffer-project))

(defun pbf-buffer-project-as-string (&optional buffer)
  (let ((prj (pbf-buffer-project)))
    (when prj
      (symbol-name (car prj)))))

(defun pbf-switch-to-buffer (buffer &optional norecord)
  (interactive
   (list (pbf-read-buffer "Switch to buffer:" (other-buffer)
			  t (not current-prefix-arg))))
  (switch-to-buffer buffer norecord))

(defvar pbf-buffer-name-history nil)
(defun pbf-read-buffer (prompt &optional def require-match all)
  (let (pbf-buffers)
    (save-excursion
      (if all
	  (setq pbf-buffers (mapcar
			     (lambda (buf)
			       (cons (progn
				       (set-buffer buf)
				       (or pbf-buffer-name
					   (buffer-name)))
				     buf))
			     (buffer-list)))
	(let ((buffers (buffer-list))
	      buf)
	  (while buffers
	    (setq buf (pop buffers))
	    (set-buffer buf)
	    (when pbf-buffer-name
	      (push (cons pbf-buffer-name buf) pbf-buffers))))))
    (when (bufferp def)
      (setq def (buffer-name def)))
    (when def
      (with-current-buffer def
	(when pbf-buffer-name
	  (setq def pbf-buffer-name)))
      (setq prompt (concat prompt " (default " def ") ")))
    (cdr (assoc (completing-read prompt pbf-buffers nil require-match nil
				 pbf-buffer-name-history def)
		pbf-buffers))))

(defun pbf-list-buffers (&optional project-only)
  "Display a list of names of existing buffers.
The list is displayed in a buffer named `*Buffer List*'.
Note that buffers with names starting with spaces are omitted.
Non-null optional arg PROJECT-ONLY means mention only project
associated buffers.

The M column contains a * for buffers that are modified.
The R column contains a % for buffers that are read-only."
  (interactive "P")
  (display-buffer (pbf-list-buffers-noselect project-only)))

(defun pbf-list-buffers-noselect (&optional project-only)
  "Create and return a buffer with a list of names of existing buffers.
The buffer is named `*Buffer List*'.
Note that buffers with names starting with spaces are omitted.
Non-null optional arg PROJECT-ONLY means mention only project
assoctiated buffers.

The M column contains a * for buffers that are modified.
The R column contains a % for buffers that are read-only."
  (let ((old-buffer (current-buffer))
	(standard-output standard-output)
	desired-point)
    (save-excursion
      (set-buffer (get-buffer-create "*Buffer List*"))
      (setq buffer-read-only nil)
      (erase-buffer)
      (setq standard-output (current-buffer))
      (princ "\
 MR Buffer           Size  Mode         File
 -- ------           ----  ----         ----
")
      ;; Record the column where buffer names start.
      (setq Buffer-menu-buffer-column 4)
      (let ((bl (buffer-list)))
	(while bl
	  (let* ((buffer (car bl))
		 (name (buffer-name buffer))
		 (file (buffer-file-name buffer))
		 this-buffer-project
		 this-buffer-line-start
		 this-buffer-read-only
		 this-buffer-size
		 this-buffer-mode-name
		 this-buffer-directory
		 this-buffer-display-name)
	    (save-excursion
	      (set-buffer buffer)
	      (setq this-buffer-project pbf-buffer-project)
	      (setq this-buffer-display-name (or pbf-buffer-name name))
	      (setq this-buffer-read-only buffer-read-only)
	      (setq this-buffer-size (buffer-size))
	      (setq this-buffer-mode-name
		    (if (eq buffer standard-output)
			"Buffer Menu" mode-name))
	      (or file
		  ;; No visited file.  Check local value of
		  ;; list-buffers-directory.
		  (if (and (boundp 'list-buffers-directory)
			   list-buffers-directory)
		      (setq this-buffer-directory list-buffers-directory))))
	    (cond
	     ;; Don't mention internal buffers.
	     ((string= (substring name 0 1) " "))
	     ;; Maybe don't mention buffers without projects.
	     ((and project-only (not this-buffer-project)))
	     ;; Otherwise output info.
	     (t
	      (setq this-buffer-line-start (point))
	      ;; Identify current buffer.
	      (if (eq buffer old-buffer)
		  (progn
		    (setq desired-point (point))
		    (princ "."))
		(princ " "))
	      ;; Identify modified buffers.
	      (princ (if (buffer-modified-p buffer) "*" " "))
	      ;; Handle readonly status.  The output buffer is special
	      ;; cased to appear readonly; it is actually made so at a later
	      ;; date.
	      (princ (if (or (eq buffer standard-output)
			     this-buffer-read-only)
			 "% "
		       "  "))
	      (princ this-buffer-display-name)
	      ;; Put the buffer name into a text property
	      ;; so we don't have to extract it from the text.
	      ;; This way we avoid problems with unusual buffer names.
	      (setq this-buffer-line-start
		    (+ this-buffer-line-start Buffer-menu-buffer-column))
	      (let ((name-end (point)))
		(indent-to 17 2)
		(put-text-property this-buffer-line-start name-end
				   'buffer-name name)
		(put-text-property this-buffer-line-start name-end
				   'mouse-face 'highlight))
	      (let (size
		    mode
		    (excess (- (current-column) 17)))
		(setq size (format "%8d" this-buffer-size))
		;; Ack -- if looking at the *Buffer List* buffer,
		;; always use "Buffer Menu" mode.  Otherwise the
		;; first time the buffer is created, the mode will be wrong.
		(setq mode this-buffer-mode-name)
		(while (and (> excess 0) (= (aref size 0) ?\ ))
		  (setq size (substring size 1))
		  (setq excess (1- excess)))
		(princ size)
		(indent-to 27 1)
		(princ mode))
	      (indent-to 40 1)
	      (or file (setq file this-buffer-directory))
	      (if file
		  (princ file))
	      (princ "\n"))))
	  (setq bl (cdr bl))))
      (Buffer-menu-mode)
      ;; DESIRED-POINT doesn't have to be set; it is not when the
      ;; current buffer is not displayed for some reason.
      (and desired-point
	   (goto-char desired-point))
      (current-buffer))))

(put :file-encoding 'pbf-type-predicate 'coding-system-p)
(defun pbf-set-file-encoding ()
  "Set buffer file encoding to project's file encoding.
See also keyword `:file-encoding' of `pbf-project'."
  (pbf-with-options (file-encoding)
    (when file-encoding
      (add-hook 'local-write-file-hooks
		`(lambda ()
		   (pbf-set-file-coding-system-for-write
		    (quote ,file-encoding)))
		nil t))))

(defun pbf-buffer-file-coding-system-fixed-p ()
  (let ((buf-base (coding-system-base buffer-file-coding-system)))
    (or (and (fboundp 'set-auto-coding)
	     (save-excursion
	       (save-restriction
		 (widen)
		 (goto-char (point-min))
		 (funcall 'set-auto-coding (buffer-file-name) (buffer-size)))))
	(not
	 (or
	  (and (eq buf-base 'undecided)
	       (not (eq (coding-system-base
			 (car (detect-coding-region (point-min) (point-max))))
			'undecided)))
	  (and (eq buf-base (coding-system-base
			     default-buffer-file-coding-system))
	       (not (eq (coding-system-base
			 (car (detect-coding-region (point-min) (point-max))))
			'undecided))))))))

(defun pbf-set-file-coding-system-for-write (cs)
  (let ((buf-base (coding-system-base buffer-file-coding-system)))
    (unless (or (pbf-buffer-file-coding-system-fixed-p)
		(and (eq buf-base (coding-system-base cs))
		     (eq (coding-system-eol-type buffer-file-coding-system)
			 (coding-system-eol-type cs))))
      (when (y-or-n-p (format "set coding system to %s instead of %s ? "
			      cs buffer-file-coding-system))
	(set-buffer-file-coding-system cs))))
  nil)

(put :c-style 'pbf-type-predicate 'stringp)
(defun pbf-c-mode-set-style ()
  "Set `c-indentation-style' to project's coding style.
See also keyword `:c-style' of `pbf-project'."
  (pbf-with-options (c-style)
    (when c-style
      (make-local-variable 'c-basic-offset)
      (make-local-variable 'c-offsets-alist)
      (make-local-variable 'c-indentation-style)
      (c-set-style c-style))))

(put :add-log-directory 'pbf-type-predicate 'stringp)
(put :add-log-file-name 'pbf-type-predicate 'stringp)
(eval-after-load "add-log"
  '(defadvice find-change-log (around pbf-add-log activate)
     "Control file name by pbf-mode.
PBF keywords
 `:add-log-directory' - Directory.
 `:add-log-file-name' - File name."
     (let ((pbf-save-change-log-default-name))
       ad-do-it
       (unless pbf-save-change-log-default-name
	 (let ((pbf-buffer-project (or pbf-buffer-project
				       (pbf-search-project-by-path
					default-directory))))
	   (setq change-log-default-name nil)
	   (pbf-with-options (add-log-directory add-log-file-name)
	     (when (or add-log-directory add-log-file-name)
	       (set (make-local-variable 'change-log-default-name)
		    (setq ad-return-value
			  (expand-file-name (or add-log-file-name
						(change-log-name))
					    add-log-directory))))))))))

(put :add-log-full-name 'pbf-type-predicate 'stringp)
(put :add-log-mailing-address 'pbf-type-predicate 'stringp)
(put :add-log-time-format 'pbf-type-predicate 'functionp)
(defun pbf-change-log-mode-set-style ()
  "Control add log style.
PBF keywords
 `:add-log-full-name' - Your full name.
                          (associated with `add-log-full-name).
 `:add-log-mailing-address' - Your mail address.
                          (associated with `add-log-mailing-address).
 `:add-log-time-format' - Function that defines the time format.
                          (associated with `add-log-time-format)."
  (let (full-name mailing-address time-format)
    (pbf-with-options (add-log-full-name
		       add-log-mailing-address
		       add-log-time-format)
      (setq full-name add-log-full-name
	    mailing-address add-log-mailing-address
	    time-format add-log-time-format))
    (and full-name
	 (set (make-local-variable 'add-log-full-name) full-name))
    (and mailing-address
	 (set (make-local-variable 'add-log-mailing-address)
	      mailing-address))
    (and time-format
	 (set (make-local-variable 'add-log-time-format)
	      time-format))))

(put :mail-to 'pbf-type-predicate 'stringp)
(put :mail-project-name 'pbf-type-predicate 'stringp)
(defvar pbf-compose-mail-function 'compose-mail)
(defvar pbf-compose-mail-project-header "X-Project")
(defun pbf-compose-mail ()
  "Send mail to buffer project related address."
  (interactive)
  (or (pbf-with-options (mail-to mail-project-name)
	(let ((prj (or mail-project-name
		       (pbf-buffer-project-as-string))))
	  (funcall pbf-compose-mail-function mail-to nil
		   (list (cons (intern pbf-compose-mail-project-header)
			       prj))))
	t)
      (funcall pbf-compose-mail-function)))

;; Option: `:cvs-update-directory'
;; Ex. for .pbf-mode.el
;; (pbf-project Elisp-Dev nil
;;     :directory (expand-file-name "~/work/elisp")
;;     :cvs-update-directory '(and (string-match
;; 				 (concat "\\`\\("
;; 					 (expand-file-name "~/work/elisp")
;; 					 "/[^/]+/\\).")
;; 				 default-directory)
;; 				(match-string 1 default-directory)))

(put :cvs-update-directory 'pbf-type-predicate 'stringp)
(defun pbf-cvs-query-directory (msg)
  ;; last-command-char = ?\r hints that the command was run via M-x
  (if (and (cvs-buffer-p)
	   (not current-prefix-arg)
	   (not (eq last-command-char ?\r)))
      default-directory
    (let ((default-directory (or (pbf-with-options (cvs-update-directory)
				   cvs-update-directory)
				 default-directory)))
	  (read-directory-name msg nil default-directory nil))))

(eval-after-load "pcl-cvs"
  '(fset 'cvs-query-directory 'pbf-cvs-query-directory))

(provide 'pbf-mode)
;; pbf-mode.el ends here
