;;; background.el --- fun with background jobs

;; Copyright (C) 1988 Joe Keane <jk3k+@andrew.cmu.edu>
;; Keywords: processes

;; This file is part of XEmacs.

;; XEmacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; XEmacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with XEmacs; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;;; Synched up with: Not in FSF

;;; Commentary:

;; - Adapted to use comint and cleaned up somewhat. Olin Shivers 5/90
;; - Background failed to set the process buffer's working directory
;;   in some cases. Fixed. Olin 6/14/90
;; - Background failed to strip leading cd's off the command string
;;   after performing them. This screwed up relative pathnames.
;;   Furthermore, the proc buffer's default dir wasn't initialised 
;;   to the user's buffer's default dir before doing the leading cd.
;;   This also screwed up relative pathnames if the proc buffer already
;;   existed and was set to a different default dir. Hopefully we've
;;   finally got it right. The pwd is now reported in the buffer
;;   just to let the user know. Bug reported by Piet Van Oostrum.
;;   Olin 10/19/90
;; - Fixed up the sentinel to protect match-data around invocations.
;;   Also slightly rearranged the cd match code for similar reasons.
;;   Olin 7/16/91
;; - Dec 29 1995: changed for new stuff (shell-command-switch, second
;;   arg to shell-command --> BUFFER-NAME arg to background) from
;;   FSF 19.30.  Ben Wing

;; My fixes and updates for work together with background-menu
;; matsl@contactor.se

;;; Code:


(provide 'background)
(require 'comint)

(defgroup background nil
  "Fun with background jobs"
  :group 'processes)


;; user variables
(defcustom background-show t
  "*If non-nil, background jobs' buffers are shown when they're started."
  :type 'boolean
  :group 'background)
(defcustom background-select nil
  "*If non-nil, background jobs' buffers are selected when they're started."
  :type 'boolean
  :group 'background)

(defcustom background-history 20
  "*If non-nil then that number of terminated % buffers are kept."
  :type 'int
  :group 'background)

(defvar background-last-job-number 1)
(defvar background-first-job-number 1)

(defvar background-this-job-number 1)
(make-variable-buffer-local 'background-this-job-number)
(setq-default background-this-job-number 1)

(defvar background-this-command nil)
(make-variable-buffer-local 'background-this-command)
(setq-default background-this-command nil)

(defcustom background-ask-about-save t
  "If not nil, M-x background asks which buffers to save before
executing command. If nil it saves all modified buffers without
asking. Finally if 'ignore it doesn't do anything about unsaved
buffers."
  :type 'boolean
  :group 'background)

(defvar background-buffer-usage nil 
  "Define how this buffer is to be used. Allowed values are nil for
plain garbage collected when history is full, 'reuse for use this
buffer again when the same command is issued and 'precious for keep
this buffer whatever happens.")
(make-variable-buffer-local 'background-buffer-usage)
(setq-default background-buffer-usage nil)

;;;###autoload
(defun background (command &optional buffer-name)
  "Run COMMAND in the background like csh.  
A message is displayed when the job starts and finishes.  The buffer is in
comint mode, so you can send input and signals to the job.  The process object
is returned if anyone cares.  See also comint-mode and the variables
background-show and background-select.

Optional second argument BUFFER-NAME is a buffer to insert the output into.
If omitted, a buffer name is constructed from the command run."
  (interactive "s%% ")
  (or (eq background-ask-about-save 'ignore)
      (save-some-buffers (not background-ask-about-save) nil))
  (let ((job-number 1)
	job-name
	job-number
        buffer-name
	(dir default-directory))
    (setq job-number
	  (if background-history 
	      (prog1 background-first-job-number 
		(setq background-first-job-number (1+ background-first-job-number)))
	    1))
    (while (get-process (setq job-name (format "background-%d" job-number)))
      (setq job-number (1+ job-number)))
    (or buffer-name
	(setq buffer-name (format "*%s*" job-name)))
    (if background-select (pop-to-buffer buffer-name)
      (if background-show (with-output-to-temp-buffer buffer-name)) ; cute
      (set-buffer (get-buffer-create buffer-name)))
    (erase-buffer)

    ;; Scan through jobs to find out what buffers should be deleted.
    (if background-history
	(let ((precious 0) (active 0) (avail 0) (delete)
	      (job background-first-job-number))
	  (while (< background-last-job-number job)
	    (let ((buff (get-buffer (format "*background-%d*" job))))
	      (if buff
		  (setq avail (1+ avail)))
	      (if (get-process (format "background-%d" job))
		  (setq active (1+ active))
		(if buff
		    (save-excursion
		      (set-buffer buff)
		      (if (eq background-buffer-usage 'precious)
			  (setq precious (1+ precious)))))))
	    (setq job (1- job)))
	  (setq delete (- (- avail active precious) background-history))
	  (setq job background-last-job-number)
	  (while (and (< 0 delete) (< job background-first-job-number))
	    (if (get-process (format "background-%d" job))
		()
	      (let ((buff (get-buffer (format "*background-%d*" job))))
		(if buff
		    (save-excursion
		      (set-buffer buff)
		      (if (eq background-buffer-usage 'precious)
			  ()
			(kill-buffer buff)
			(setq delete (1- delete)))))))
	    (setq job (1+ job)))
	  (while (not (get-buffer (format "*background-%d*" background-last-job-number)))
	    (setq background-last-job-number (1+ background-last-job-number)))))

    (setq default-directory dir) ; Do this first, in case cd is relative path.
    (if (string-match "^cd[\t ]+\\([^\t ;]+\\)[\t ]*;[\t ]*" command)
	(let ((dir (substring command (match-beginning 1) (match-end 1))))
	   (setq command (substring command (match-end 0)))
	   (setq default-directory
		 (file-name-as-directory (expand-file-name dir)))))

    (insert "--- working directory: \"" (abbreviate-file-name default-directory t)
	    "\"\n% " command ?\n)

    (let ((proc (get-buffer-process
		 (comint-exec buffer-name job-name shell-file-name
			      nil (list shell-command-switch command)))))
      (comint-mode)
      ;; COND because the proc may have died before the G-B-P is called.
      (cond (proc (set-process-sentinel proc 'background-sentinel)
		  (message "[%d] %d" job-number (process-id proc))))
      (setq mode-name "Background")
      (setq background-this-command command)
      (setq background-this-job-number job-number)
      proc)))


(defun background-sentinel (process msg)
  "Called when a background job changes state."
  (let ((ms (match-data))) ; barf
    (unwind-protect
	 (let ((msg (cond ((string= msg "finished\n") "Done")
			  ((string-match "^exited" msg)
			   (concat "Exit " (substring msg 28 -1)))
			  ((zerop (length msg)) "Continuing")
			  (t (concat (upcase (substring msg 0 1))
				     (substring msg 1 -1))))))
	   (message "[%s] %s %s" (process-name process)
		    msg
		    (nth 2 (process-command process)))
	   (if (null (buffer-name (process-buffer process)))
	       (set-process-buffer process nil) ; WHY? Olin.
	       (if (memq (process-status process) '(signal exit))
		   (save-excursion
		     (set-buffer (process-buffer process))
		     (let ((at-end (eobp)))
		       (save-excursion
			 (goto-char (point-max))
			 (insert ?\n msg ? 
				 (substring (current-time-string) 11 19) ?\n))
		       (if at-end (goto-char (point-max))))
		     (set-buffer-modified-p nil)))))
      (store-match-data ms))))

(defun background-next ()
  "Move to the next background buffer."
  (interactive)
  (let* ((next background-this-job-number)
	 (buffer nil))
    (while (and (< next background-first-job-number) (not buffer))
      (setq next (+ next 1))
      (setq buffer (get-buffer (format "*background-%d*" next)))
      (if buffer (switch-to-buffer buffer)))
    (if (not buffer)
	(progn
	  (beep)
	  (message "On the bottom")))))

(defun background-previous ()
  "Move to the previous background buffer."
  (interactive)
  (let* ((next background-this-job-number)
	 (buffer nil))
    (while (and (> next background-last-job-number) (not buffer))
      (setq next (- next 1))
      (setq buffer (get-buffer (format "*background-%d*" next)))
      (if buffer (switch-to-buffer buffer)))
    (if (not buffer)
	(progn
	  (beep)
	  (message "On the top")))))

(defun background-redo ()
  "Redo command"
  (interactive)
  (background background-this-command))

;; XXX: Could test here that this really is a background-buffer.
(defun background-precious-p (buff)
  "True if precious"
  (save-excursion
    (set-buffer buff)
    (eq background-buffer-usage 'precious)))

(defun background-toggle-precious (buff)
  "Toggle the precious flag."
  (save-excursion
    (set-buffer buff)
    (if (eq background-buffer-usage 'precious)
	(setq background-buffer-usage nil)
      (setq background-buffer-usage 'precious))))

(define-key comint-mode-map [(control c) p] 'background-previous)
(define-key comint-mode-map [(control c) n] 'background-next)
(define-key comint-mode-map [(control c) !] 'background-redo)
