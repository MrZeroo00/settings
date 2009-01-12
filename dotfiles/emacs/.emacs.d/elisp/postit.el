;;; -*-coding: emacs-mule;-*-

(require 'cl)
(autoload 'ange-ftp-file-readable-p "ange-ftp" nil t) ; XXX

;;; defcustom XXX
(defvar postit-file "~/.postit"
  "The file name to which postit contents are saved.")
(defvar postit-file-mode-string "600"
  "The permission information of `postit-file'.")
(defvar postit-file-backup-level nil) ; or integer >= 0
(defvar postit-file-backup-directory "~/")

(defvar postit-compress-commands
  '("gzip" ("--best") ".gz" "zcat" ())
  "List of compress command, its options, compressed `postit-file' suffix,
uncompress command and its options.
If you don't want to compress `postit-file', set this variable to nil.

Examples:
(\"compress\" () \".Z\" \"zcat\" ())
(\"bzip2\" (\"--repetitive-best\") \".bz2\" \"bunzip2\" (\"--stdout\"))
(\"zip\" (\"-9\") \".zip\" \"unzip\" (\"-p\"))
(\"pack\" () \".z\" \"pcat\" ())

Note: lha is not usable.
")

(defvar postit-urls
  "\\(http:/\\|ftp:/\\|file:/\\|gopher:/\\|telnet:/\\)[!#-'*-;=?-~]*")
(defvar postit-browser nil) ; netscape, w3, mmm, ...
(defvar postit-browser-alist ; XXX
  '((netscape . "netscape") (w3 . "w3") (mmm . "mmm") (lynx . "lynx")))

(defvar postit-always-show-all-entry nil)

(defvar postit-window-split-value 12)

(defvar postit-self-organize nil)

(defvar postit-link-commands
  '(("dvi" "xdvi") ("ps" "gv" "-antialias") ("ps.gz" "gv" "-antialias")
    ("pdf" "xpdf")
    ("gif" "xv") ("jpg" "display") ("png" "display")
    )
  "Commands invoked when you want to view the link to a file.
This varialbe is an association list and each elements consists of
the form:
car of the cell: file suffix,
cdr of the cell: associated command name and its options.
If a file is not associated to any command by this variable,
the file is simply `find-file'ed when you intend to see it.")

;; Colors
(defvar postit-colorize 'light) ; 'dark or nil
; for ("light background" . "dark background")
(defvar postit-title-color '("dark green" . "yellow"))
(defvar postit-time-color '("blue" . "light green"))
(defvar postit-link-color '("blue violet" . "Misty Rose"))
(defvar postit-ftp-color '("dark orange" . "sky blue"))
(defvar postit-url-color '("brown3" . "aquamarine"))
(defvar postit-category-color '("DarkGoldenrod" . "tomato"))
(defvar postit-search-highlight-color '("light green" . "MediumPurple1"))

;; hooks
(defvar postit-mode-hook nil)
(defvar postit-edit-mode-hook nil)

;; Codes
(defvar postit-buffer-name " *Postit Contents*")
(defvar postit-title-buffer-name "*Postit*")
(defvar postit-show-buffer-name "*Postit Show*")
(defvar postit-header-buffer-name "*Postit Header*")
(defvar postit-edit-buffer-name "*Postit Edit*")
(defvar postit-search-buffer-name "*Postit Search*")
(defvar postit-process-buffer-name " *Postit Command Process*")
(defvar postit-sub-process-buffer-name " *Postit Command Sub Process")
(defvar postit-buffer nil)
(defvar postit-title-buffer nil)
(defvar postit-show-buffer nil)
(defvar postit-header-buffer nil)
(defvar postit-edit-buffer nil)
(defvar postit-search-buffer nil)

(defvar postit-previous-location nil)
(defvar postit-current-location nil)
(defvar postit-contents nil)
(defvar postit-line-to-content-alist nil)
(defvar postit-content-to-line-alist nil)

(defvar postit-has-already-started nil)

(defvar postit-showing-p nil)
(defvar postit-showing-header-p nil)
(defvar postit-previous-window-configuration nil)
(defvar postit-current-window-configuration nil)

(defvar postit-save-files nil)

(defvar postit-yank nil)

(defvar postit-edit-or-make nil)

(defvar postit-browser-inner-alist ; XXX should sync with postit-browser-alist
  '(("netscape" . netscape) ("w3" . w3) ("mmm" . mmm) ("lynx" . lynx)))

;; keymaps
(defvar postit-mode-map nil)

(defvar postit-edit-mode nil)
(make-variable-buffer-local 'postit-edit-mode)
(setplist 'postit-edit-mode '(permanent-local t))
(defvar postit-edit-mode-map nil)

;; faces
(and postit-colorize
     (mapcar (lambda (face-and-color)
	       (let ((face (car face-and-color))
		     (color (cond ((eq 'light postit-colorize)
				   (cadr face-and-color))
				  ((eq 'dark postit-colorize)
				   (cddr face-and-color))
				  (t "black")))) ; XXX
		 (make-face face)
		 (set-face-foreground face color)))
	     (list (cons 'postit-title-face postit-title-color)
		   (cons 'postit-time-face postit-time-color)
		   (cons 'postit-link-face postit-link-color)
		   (cons 'postit-ftp-face postit-ftp-color)
		   (cons 'postit-url-face postit-url-color)
		   (cons 'postit-category-face postit-category-color)
		   (cons 'postit-search-face postit-search-highlight-color)
		   )))

(or postit-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map "Q" 'postit-quit)
      (define-key map "S" 'postit-save)
      (define-key map "q" 'postit-save-and-quit)
      (define-key map "m" 'postit-make-memo)
      (define-key map "M" 'postit-make-memo-text)
      (define-key map "F" 'postit-make-memo-folder)
      (define-key map "e" 'postit-edit-memo)
      (define-key map "n" 'postit-next-memo)
      (define-key map "p" 'postit-previous-memo)
      (define-key map "\M-<" 'postit-goto-top)
      (define-key map "\M->" 'postit-goto-bottom)
      (define-key map "\C-f" 'postit-enter-folder)
      (define-key map "\C-b" 'postit-leave-folder)
      (define-key map "\C-t" 'postit-toggle-folder-visible)
      (define-key map "t" 'postit-toggle-folder-visible)
      (define-key map "\C-n" 'postit-next-title)
      (define-key map "\C-p" 'postit-previous-title)
      (define-key map "\C-s" 'postit-isearch-forward)
      (define-key map "\C-r" 'postit-isearch-backward)
      (define-key map " " 'postit-show-content-maybe)
      (define-key map "o" 'postit-show-content-force)
      (define-key map "\177" 'postit-memo-backscroll)
      (define-key map "c" 'postit-close-other-windows)
      (define-key map "\C-k" 'postit-remove-content)
      (define-key map "\C-y" 'postit-paste-from-yank)
      (define-key map "r" 'postit-rename-title)
      (define-key map "s" 'postit-search-string)
;       (define-key map "h" 'postit-toggle-header)
      ; X specific ?
      (define-key map [down] 'postit-next-title)
      (define-key map [up] 'postit-previous-title)
      (define-key map [right] 'postit-enter-folder)
      (define-key map [left] 'postit-leave-folder)

      ; Mouse
      (define-key map [down-mouse-1] 'postit-show-mouse-position)

      ; Menu bar
      (define-key map [menu-bar postit] (cons "Postit" map))
      (define-key map [menu-bar postit sort-by-date]
	'("Sort by date" . postit-sort-by-date))
      (define-key map [menu-bar postit sort-by-title]
	'("Sort by title" . postit-sort-by-title))
      (define-key map [menu-bar postit separator-1] '("--"))
      (define-key map [menu-bar postit make-folder]
	'("Make a foler" . postit-make-memo-folder))
      (define-key map [menu-bar postit make-text-memo]
	'("Make a text memo" . postit-make-memo-text))

      (setq postit-mode-map map)
      ))

(or postit-edit-mode-map
    (progn
      (setq postit-edit-mode-map (make-sparse-keymap))
      (define-key postit-edit-mode-map "\C-c\C-c" 'postit-entry-register)
      (define-key postit-edit-mode-map "\C-x\C-s" 'postit-entry-register)
      (define-key postit-edit-mode-map "\C-cq" 'postit-entry-register-and-quit)
      (define-key postit-edit-mode-map "\C-cQ" 'postit-quit)
      (define-key postit-edit-mode-map "\C-c\C-s" 'postit-entry-register-and-save)
      ))

(or (assq 'postit-edit-mode minor-mode-alist)
    (setq minor-mode-alist
	  (cons '(postit-edit-mode " PstIt-Ed") minor-mode-alist)
	  minor-mode-map-alist
	  (cons (cons 'postit-edit-mode postit-edit-mode-map)
		minor-mode-map-alist)))

;;; menu-bar XXX
;(define-key menu-bar-tools-menu [postit] '("Postit" . postit))

;; internal functions
(defun postit-fetch-url-by-netscape (url)
  (let ((netscape-command (cdr (assq 'netscape postit-browser-alist))))
    (if (zerop (call-process netscape-command nil nil nil
			     "-remote" (concat "openURL(" url ")")))
	(message "%s" (format "Fetching %s ... done." url))
      (progn ; Netscape not running - start it
	(message "%s" (format "Starting Netscape for %s ..." url))
	(apply 'start-process "netscape" nil netscape-command (list url))
	(message "%s" (format "Starting Netscape for %s ... done." url))))))

(defun postit-fetch-url-by-lynx (url)
  (apply 'start-process "lynx on kterm" nil "/usr/local/X11R6.3/bin/kterm"
	 (list "-geometry" "110x45" "-km" "euc" "-e" "lynx" url)))
; (apply 'start-process "lynx on kterm" nil "/usr/local/X11R6.3/bin/kterm"
;        '("-geometry" "110x45" "-km" "euc" "-e" "lynx"))

; (setq process-environment
;       '("LC_TIME=C" "TZ=JST-9" "PWD=/auto/home/is/hiroki-t" "HOME=/home/is/hiroki-t" "REMOTEHOST=sgi164.aist-nara.ac.jp" "SHELL=/bin/csh" "DISPLAY=sgi164.aist-nara.ac.jp:0.0" "USER=hiroki-t" "LOGNAME=hiroki-t" "XUSERFILESEARCHPATH=/home/is/hiroki-t/.desktop-sgi164.aist-nara.ac.jp/%N:/home/is/hiroki-t/%N:/home/is/hiroki-t/.desktop-sgi164.aist-nara.ac.jp/0.0/%N" "REMOTEUSER=hiroki-t" "PATH=/usr/local/bin:/usr/sbin:/usr/bsd:/sbin:/usr/bin:/usr/bin/X11:" "LANG=" "LD_LIBRARYN32_PATH=/usr/local/lib" "WWW_HOME=http://nara.aist-nara.ac.jp/" "_=/usr/local/bin/emacs"))


; (what-line) ???
(defun postit-current-absolute-line ()
  "Returns the line at the cursor point."
  (+ (count-lines (point-min) (point))
     (if (= (current-column) 0) 1 0)))

(defun postit-setq-nth (n list obj) ; (length list) >= 1
  (if (= 0 n)
      (setcar list obj)
    (postit-setq-nth (- n 1) (cdr list) obj)))

(defun postit-increment-last-1 (list) ; (length list) >= 1
;   (while (< 1 (length list)) ; imperative
;     (setq list (cdr list)))
;   (setcar list (1+ (car list))))
  (let ((rev (reverse list))) ; functional
    (if (null (car rev))
	list
      (reverse (cons (1+ (car rev))
		     (cdr rev))))))

(defun postit-decrement-last-1 (list)
  (let ((rev (reverse list)))
    (if (or (null (car rev)) ; ↓ この順序は重要。null のあと =
	    (= 1 (car rev))) ; ↓
	list
      (reverse (cons (1- (car rev))
		     (cdr rev))))))

(defun postit-make-last-nil (list) ; (length list) >= 1
  (let ((rev (reverse list)))
    (reverse (cons nil (cdr rev)))))

(defun postit-make-line-to-content-alist-aux (contents line location)
  (if (equal '(nil) contents)
      (cons (list (cons line (postit-make-last-nil location))) (1+ line))
    (let ((alist '())
	  (current-location location)
	  (current-line line))
      (while contents
	(let ((content (car contents)))
	  (setq alist (cons (cons line current-location) alist))
	  (setq line (1+ line))
	  (if (eq 'folder (car content))
	      (let* ((sub-contents (nth 4 content))
		     (sub-location (reverse (cons 1 (reverse current-location))))
		     (sub-alist (postit-make-line-to-content-alist-aux sub-contents line sub-location)))
		(setq line (cdr sub-alist))
		(setq alist (append alist (car sub-alist))))))
	(setq current-location (postit-increment-last-1 current-location))
	(setq contents (cdr contents)))
      (cons alist line))))

(defun postit-make-line-to-content-alist ()
  (setq postit-line-to-content-alist
	(car (postit-make-line-to-content-alist-aux postit-contents 1 '(1)))))

(defun postit-make-content-to-line-alist () ; XXX location -> line is necessary
  (setq postit-content-to-line-alist
	(mapcar (lambda (list)
		  (cons (cdr list) (car list)))
		postit-line-to-content-alist)))

(defun postit-assoc-content (location) ; XXX ???
  (let ((loc location)
	(contents postit-contents))
    (if (equal '(nil) (last loc))
	'(nil)
      (while loc
	(if (eq 'folder (car contents))
	    (setq contents (nth 4 contents)))
	(setq contents (nth (1- (car loc)) contents))
	(setq loc (cdr loc)))
      contents)))


;;; functions for moving around contents
(defun postit-goto-location (location) ; もしそこまでで開いていない folder があれば開ける。XXX
  (let ((hit (assoc location postit-content-to-line-alist)))
    (if hit ; always hit, ... XXX
	(let ((loc location)
	      (contents postit-contents))
	  (while (> (length loc) 1)
	    (if (null (nth 7 (nth (1- (car loc)) contents)))
		(postit-setq-nth 8 (nth (1- (car loc)) contents) t))
	    (setq contents (nth 4 (nth (1- (car loc)) contents)))
	    (setq loc (cdr loc)))
;	(progn
	  (goto-line (+ 2 (cdr hit)))
	  (forward-char (* 2 (1- (length location))))
	  (setq postit-previous-location postit-current-location)
	  (setq postit-current-location location)))))

(defun postit-next-title ()
  (interactive)
  (let* ((current-location postit-current-location)
	 (next-location (postit-increment-last-1 current-location))
	 (hit (assoc next-location postit-content-to-line-alist)))
    (if hit
	(progn
	  (postit-goto-location next-location)))))

(defun postit-next-memo ()
  (interactive)
  (postit-next-title)
  (postit-show-content 'moving))

(defun postit-previous-title ()
  (interactive)
  (let* ((current-location postit-current-location)
	 (next-location (postit-decrement-last-1 current-location))
	 (hit (assoc next-location postit-content-to-line-alist)))
    (if hit
	(progn
	  (postit-goto-location next-location)))))

(defun postit-previous-memo ()
  (interactive)
  (postit-previous-title)
  (postit-show-content 'moving))

(defun postit-goto-top ()
  (interactive)
  (postit-goto-location (cdr (assoc 1 postit-line-to-content-alist))))

(defun postit-goto-bottom ()
  (interactive)
  (let ((largest 1)
	(alist postit-line-to-content-alist))
    (while alist
      (if (< largest (car (car alist)))
	  (setq largest (car (car alist))))
      (setq alist (cdr alist)))
    (postit-goto-location (cdr (assoc largest postit-line-to-content-alist)))))

(defun postit-enter-folder ()
  (interactive)
  (let ((content (postit-assoc-content postit-current-location)))
    (if (eq 'folder (car content))
	(let ((new-location
	       (reverse (cons (nth 9 content)
			      (reverse postit-current-location)))))
	  (if (null (nth 8 content))
	      (progn
		(postit-setq-nth 8 content t)
		(postit-show-titles)))
	  (postit-goto-location new-location))
      (message "This is not a folder."))))

(defun postit-leave-folder ()
  (interactive)
  (if (= 1 (length postit-current-location))
      ()
    (let ((new-location (reverse (cdr (reverse postit-current-location))))
	  (last (car (reverse postit-current-location))))
      (postit-goto-location new-location)
      (setcar (nthcdr 9 (postit-assoc-content new-location)) last)
      (if (nth 8 (postit-assoc-content new-location))
	  (progn
	    (postit-setq-nth 8 (postit-assoc-content new-location) nil)
	    (postit-show-titles)))))) ; XXX

(defun postit-toggle-folder-visible ()
  (interactive)
  (let ((content (postit-assoc-content postit-current-location)))
    (if (eq 'folder (car content))
	(progn
	  (postit-setq-nth 7 content (not (nth 7 content)))
	  (postit-show-titles)))))

(defun postit-isearch-forward ()
  (interactive)
  (isearch-forward)
  (let ((location (cdr (assoc (- (postit-current-absolute-line) 2)
			      postit-line-to-content-alist))))
    (postit-goto-location location)))

(defun postit-isearch-backward ()
  (interactive)
  (isearch-backward)
  (let ((location (cdr (assoc (- (postit-current-absolute-line) 2)
			      postit-line-to-content-alist))))
    (postit-goto-location location)))

;;; functions for adding, setting, removing and modifying memo
(defun postit-add-read-only (string)
  (add-text-properties 0 (length string) '(read-only t) string)
  string)

;; ? use assoc-content ?
(defun postit-add-new-content (content)
  "Add a new content at the current location."
  (let* ((loc postit-current-location)
	 (contents postit-contents)
	 (n (car (reverse loc)))
	 (parent nil))
    (while (< 1 (length loc))
      (setq contents (nth (1- (car loc)) contents))
      (if (eq 'folder (car contents))
	  (progn
	    (setq parent contents)
	    (setq contents (nth 4 contents))))
      (setq loc (cdr loc)))
    (if (null n) ; (equal '(nil) contents)
	(progn
	  (setcar contents content)
	  (setq postit-current-location
		(reverse (cons 1 (cdr (reverse postit-current-location)))))
	  (if parent
	      (setcar (nthcdr 9 parent) 1)))
      (while (< 1 n)
	(setq contents (cdr contents))
	(setq n (1- n)))
      (setcdr contents (cons (car contents) (cdr contents)))
      (setcar contents content))))

; (defun postit-add-new-content (content)
;   (let* ((location (reverse (cdr (reverse postit-current-location))))
; 	 (hit (postit-assoc-content location))
; 	 (last (car (reverse postit-current-location))))
;     (if hit
; 	(if (null last)
; 	    (setcar (nthcdr 4 hit) (list content))
; 	  (setcdr (nthcdr (1- last) (nthcdr 4 hit))
; 		  (cons (car (nthcdr (1- last) (nthcdr 4 hit)))
; 			(cdr (nthcdr (1- last) (nthcdr 4 hit)))))
; 	  (setcar (nthcdr (1- last) (nthcdr 4 hit)) content))
;       (setcdr (nthcdr (1- last) postit-contents)
; 	      (car (nthcdr (1- last) postit-contents))
; 	      (cdr (nthcdr (1- last) postit-contents)))
;       (setcar (nthcdr (1- last) postit-contents) content))))

(defun postit-set-new-content (content)
  "Substitute a new content for the content at the current location."
  (let* ((loc postit-current-location)
	 (contents postit-contents)
	 (n (car (reverse loc))))
    (while (< 1 (length loc))
      (setq contents (nth (1- (car loc)) contents))
      (setq loc (cdr loc))
      (if (eq 'folder (car contents))
	  (setq contents (nth 4 contents))))
    (while (< 1 n)
      (setq contents (cdr contents))
      (setq n (1- n)))
    (setcar contents content)))

(defun postit-remove-content ()
  "Remove the content at the current location, and yank"
  (interactive)
  (let* ((loc postit-current-location)
	 (contents postit-contents)
	 (n (car (reverse loc))))
    (if (null n) ; same as (equal '(nil) (postit-assoc-content postit-current-location))
	(message "There's no memo.")
      (while (< 1 (length loc))
	(setq contents (nth (1- (car loc)) contents))
	(setq loc (cdr loc))
	(if (eq 'folder (car contents))
	    (setq contents (nth 4 contents))))
      (if (= 1 (length contents))
	  (progn
	    (setq postit-yank
		  (if (eq last-command 'postit-remove-content)
		      (cons (car contents) postit-yank)
		    (list (car contents))))
	    (setcar contents nil)
	    (setq postit-current-location
		  (postit-make-last-nil postit-current-location)))
	(let ((parent nil))
	  (while (< 1 n)
	    (setq parent contents)
	    (setq contents (cdr contents))
	    (setq n (1- n)))
	  (setq postit-yank
		(if (eq last-command 'postit-remove-content)
		    (cons (car contents) postit-yank)
		  (list (car contents))))
	  (if (= 1 (length contents))
	      (progn
		(setcdr parent nil)
		(setq postit-current-location
		      (postit-decrement-last-1 postit-current-location)))
	    (setcar contents (cadr contents))
	    (setcdr contents (cddr contents)))))))
  (postit-show-titles))

(defun postit-paste-from-yank ()
  "Paste the yanked contents into the current location."
  (interactive)
  (let ((yank postit-yank))
    (while yank
      (postit-add-new-content (car yank))
      (setq yank (cdr yank))))
  (postit-show-titles))


;;; sort contents.
(defun postit-sort-prepare-aux (contents)
  (mapcar (lambda (content)
	    (if (eq 'folder (car content))
		(list nil (nth 0 content) (nth 1 content) (nth 2 content)
		      (nth 3 content) (postit-sort-prepare-aux (nth 4 content))
		      (nth 5 content) (nth 6 content) (nth 7 content)
		      (nth 8 content) (nth 9 content))
	      (cons nil content)))
	  contents))

(defun postit-sort-prepare ()
  (let* ((cntnt1 (postit-sort-prepare-aux postit-contents))
	 (result cntnt1)
	 (loc postit-current-location))
    (while (> (length loc) 1)
      (setq result (nth 5 (nth (1- (car loc)) result))) ; 4 + 1
      (setq loc (cdr loc)))
    (if (null (car loc))
	(setcar (car result) t)
      (setcar (nth (1- (car loc)) result) t))
    cntnt1))

(defun postit-sort-purge-aux-1 (attached-contents location)
  ; search `t' and returns the location.
  (cond ((equal '((t)) attached-contents)
	 (postit-make-last-nil location))
	((equal '((nil)) attached-contents)
	 nil)
	(t
	 (let ((current-location location)
	       (result nil))
	   (while (and attached-contents (not result))
	     (cond ((eq t (nth 0 (car attached-contents)))
		    (setq result current-location))
		   ((eq 'folder (nth 1 (car attached-contents)))
		    (setq result (postit-sort-purge-aux-1 (nth 5 (car attached-contents))
							  (reverse (cons 1 (reverse current-location)))))))
	     (setq attached-contents (cdr attached-contents))
	     (setq current-location (postit-increment-last-1 current-location))
	     )
	   result))))

(defun postit-sort-purge-aux-2 (attached-contents)
  ; remove `t' and `nil' at the head of each content,
  ; i.e. make the original postit-contents.
  (mapcar (lambda (content)
	    (if (eq 'folder (nth 1 content))
		(list (nth 1 content) (nth 2 content) (nth 3 content)
		      (nth 4 content) (postit-sort-purge-aux-2 (nth 5 content))
		      (nth 6 content) (nth 7 content) (nth 8 content)
		      (nth 9 content) (nth 10 content))
	      (cdr content)))
	  attached-contents))

(defun postit-sort-purge (attached-contents)
  ; search `t', returns the location, and restore `postit-contents'.
  (let ((location (postit-sort-purge-aux-1 attached-contents '(1))))
    (setq postit-contents (postit-sort-purge-aux-2 attached-contents))
    location))

(defun postit-sort-by-title-aux (attached-contents)
  (if (<= (length attached-contents) 1)
      attached-contents
    (let* ((pivot (progn
		    (if (eq 'folder (nth 1 (car attached-contents)))
			(postit-setq-nth 5 (car attached-contents)
					 (postit-sort-by-title-aux
					  (nth 5 (car attached-contents)))))
		    (car attached-contents)))
	   (pivot-title (nth 2 pivot))
	   (rest (cdr attached-contents))
	   (smaller '())
	   (bigger '()))
      (while rest
	(if (eq 'folder (nth 1 (car rest)))
	    (postit-setq-nth 5 (car rest)
			     (postit-sort-by-title-aux (nth 5 (car rest)))))
	(if (string< (nth 2 (car rest)) pivot-title)
	    (setq smaller (cons (car rest) smaller))
	  (setq bigger (cons (car rest) bigger)))
	(setq rest (cdr rest)))
      (append (postit-sort-by-title-aux smaller)
	      (list pivot)
	      (postit-sort-by-title-aux bigger)))))

(defun postit-sort-by-title ()
  (interactive)
  (let* ((attached-contents (postit-sort-prepare))
	 (sorted (postit-sort-by-title-aux attached-contents))
	 (new-location (postit-sort-purge sorted)))
    (postit-show-titles)
    (postit-goto-location new-location)))

(defun postit-time< (time1 time2)
  (or (< (nth 0 time1) (nth 0 time2))
      (and (= (nth 0 time1) (nth 0 time2))
	   (< (nth 1 time1) (nth 1 time2)))
      (and (= (nth 0 time1) (nth 0 time2))
	   (= (nth 1 time1) (nth 1 time2))
	   (< (nth 2 time1) (nth 2 time2)))))

(defun postit-sort-by-date-aux (attached-contents)
  (if (<= (length attached-contents) 1)
      attached-contents
    (let* ((pivot (progn
		    (if (eq 'folder (nth 1 (car attached-contents)))
			(postit-setq-nth 5 (car attached-contents)
					 (postit-sort-by-date-aux
					  (nth 5 (car attached-contents)))))
		    (car attached-contents)))
	   (pivot-date (nth 3 pivot))
	   (rest (cdr attached-contents))
	   (smaller '())
	   (bigger '()))
      (while rest
	(if (eq 'folder (nth 1 (car rest)))
	    (postit-setq-nth 5 (car rest)
			     (postit-sort-by-date-aux (nth 5 (car rest)))))
	(if (postit-time< (nth 3 (car rest)) pivot-date)
	    (setq smaller (cons (car rest) smaller))
	  (setq bigger (cons (car rest) bigger)))
	(setq rest (cdr rest)))
      (append (postit-sort-by-date-aux bigger)
	      (list pivot)
	      (postit-sort-by-date-aux smaller)))))

(defun postit-sort-by-date ()
  (interactive)
  (let* ((attached-contents (postit-sort-prepare))
	 (sorted (postit-sort-by-date-aux attached-contents))
	 (new-location (postit-sort-purge sorted)))
    (postit-show-titles)
    (postit-goto-location new-location)))

(defun postit-sort-by-access-count-aux (attached-contents)
  (if (<= (length attached-contents) 1)
      attached-contents
    (let* ((pivot (progn
		    (if (eq 'folder (nth 1 (car attached-contents)))
			(postit-setq-nth 5 (car attached-contents)
					 (postit-sort-by-access-count-aux
					  (nth 5 (car attached-contents)))))
		    (car attached-contents)))
	   (pivot-count (nth 6 pivot))
	   (rest (cdr attached-contents))
	   (smaller '())
	   (bigger '()))
      (while rest
	(if (eq 'folder (nth 1 (car rest)))
	    (postit-setq-nth 5 (car rest)
			     (postit-sort-by-access-count-aux (nth 5 (car rest)))))
	(if (< (nth 6 (car rest)) pivot-count)
	    (setq smaller (cons (car rest) smaller))
	  (setq bigger (cons (car rest) bigger)))
	(setq rest (cdr rest)))
      (append (postit-sort-by-access-count-aux bigger)
	      (list pivot)
	      (postit-sort-by-access-count-aux smaller)
	      ))))

(defun postit-sort-by-access-count ()
  (let* ((attached-contents (postit-sort-prepare))
	 (sorted (postit-sort-by-access-count-aux attached-contents))
	 (new-location (postit-sort-purge sorted)))
    (postit-make-line-to-content-alist)
    (postit-make-content-to-line-alist)
    (setq postit-current-location new-location)))

;;; making memo.
(defun postit-make-memo-text (title)
  (interactive "sTitle: ")
  (setq postit-edit-or-make t)
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (setq postit-edit-buffer (get-buffer-create postit-edit-buffer-name))
  (delete-other-windows)
  (split-window-vertically postit-window-split-value)
  (other-window 1)
  (switch-to-buffer postit-edit-buffer)
  (insert (concat (postit-add-read-only "Title:") " " title "\n"))
  (insert (concat (postit-add-read-only "Category: tex") "t\n"))
  (insert (concat (postit-add-read-only "Subject") ":\n"))
  (insert (concat (postit-add-read-only "--text follows this line--") "\n"))
  (make-local-hook 'change-major-mode-hook)
  (add-hook 'change-major-mode-hook
	    (function (lambda ()
			(setq postit-edit-mode t)))
	    nil t)
  (run-hooks 'postit-edit-mode-hook)
  (setq postit-edit-mode t))

(defun postit-make-memo-link (title)
  (let* ((file (read-file-name "Filename: "))
	 (time (current-time))
	 (content (list 'link title time "" file 1 t '())))
    (postit-add-new-content content)
;    (set-buffer postit-title-buffer-name)
    (postit-show-titles)))

(defun postit-make-memo-ftp (title)
  (let* ((host (read-from-minibuffer "ftp host: "))
	 (user (read-from-minibuffer "user name: "))
	 (file (let ((fullfile (read-file-name
				"file name: "
				(concat "/" user "@" host ":~/"))))
		 (substring fullfile (1+ (string-match ":" fullfile)))))
	 (time (current-time))
	 (content (list 'ftp title time ""
			(list host user file)
			1 t '())))
    (postit-add-new-content content)
    (postit-show-titles)))

(defun postit-make-memo-url (title)
  (let ((url (read-from-minibuffer "URL: "))
	(browser (if postit-browser
		     postit-browser
		   (cdr (assoc (completing-read "Choose browser: "
						postit-browser-inner-alist
						nil t)
			       postit-browser-inner-alist)))))
    (postit-add-new-content
     (list 'url title (current-time) "" (list url browser) 1 t '()))
    (postit-show-titles)))

(defun postit-make-memo-folder (title)
  (interactive "sFolder title: ")
  (postit-add-new-content
   (list 'folder title (current-time) "" (cons nil '()) 1 t t nil nil)) ; nil?
  (setq postit-current-location ; make folder and enter it.
	(reverse (cons nil (reverse postit-current-location))))
  (postit-show-titles))

(defun postit-make-memo (title category)
  "Make a memo. It shoule be
* a plain text memo or
* link to a file or
* link to a file on a remote host or
* URL.

TITLE is the name of memo, CATEGORY is which the memo belongs to."
  (interactive "sInput title: \ncCategory t(text), l(link), f(ftp), u(URL), F(folder): ")
  (cond ((= category ?t) ; text
	 (postit-make-memo-text title))
        ((= category ?l) ; link to a file
	 (postit-make-memo-link title))
        ((= category ?f) ; link to a file on a remote host
	 (postit-make-memo-ftp title))
        ((= category ?u) ; URL
	 (postit-make-memo-url title))
	((= category ?F) ; make folder
	 (postit-make-memo-folder title))))

;; quick post-it interface
(defun postit-now (string) ; XXX the name
  (interactive "sMemo: ")
  (let ((content (list 'text "" (current-time) "" string 1 t '())))
    (if postit-contents
	(postit-add-new-content content)
      (and (postit-load)
	   (postit-add-new-content content)))))

(defun postit-region (start end)
  (interactive "r")
  (let ((content (list 'text "" (current-time) ""
		       (buffer-substring start end) 1 t '())))
    (if postit-contents
	(postit-add-new-content content)
      (and (postit-load)
	   (postit-add-new-content content)))))

(defun postit-this-file () ; XXX not saved, on remote host
  (interactive)
  (let* ((file (buffer-file-name (current-buffer)))
	 (home-dir (expand-file-name "~/"))
	 (link-file (if (string-match (concat "^\\(" home-dir "\\)") file)
			(concat "~/" (substring file (match-end 1)))
		      file))
	 (content (list 'link "" (current-time) ""
			link-file 1 t '())))
    (if (and postit-contents
	     file)
	(postit-add-new-content content)
      (and (postit-load)
	   file
	   (postit-add-new-content content)))))

;; edit memo
(defun postit-edit-memo-text (content)
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (setq postit-edit-buffer (get-buffer-create postit-edit-buffer-name))
  (set-buffer postit-edit-buffer)
  (insert (concat (postit-add-read-only "Title:") " " (nth 1 content) "\n"))
  (insert (concat (postit-add-read-only "Category: tex") "t\n"))
  (insert (concat (postit-add-read-only "Subject:") " " (nth 3 content) "\n"))
  (insert (concat (postit-add-read-only "--text follows this line--") "\n"))
  (insert (nth 4 content))
  (delete-other-windows) ; XXX
  (split-window-vertically postit-window-split-value)
  (other-window 1)
  (switch-to-buffer postit-edit-buffer)
  (setq postit-edit-or-make nil)
  (if (car (nth 7 content))
      (call-interactively (car (nth 7 content)))) ; XXX
  (make-local-hook 'change-major-mode-hook)
  (add-hook 'change-major-mode-hook
	    (function (lambda ()
			(setq postit-edit-mode t)))
	    nil t)
  (run-hooks 'postit-edit-mode-hook)
  (setq postit-edit-mode t))

(defun postit-edit-memo-ftp (content)
  (let* ((file (nth 2 (nth 4 content)))
	 (ange-file (concat "/" (nth 1 (nth 4 content)) ; user
			    "@"
			    (nth 0 (nth 4 content)) ; host
			    ":" file))
	 (command-p (catch 'command
		      (let ((commands postit-link-commands))
			(while commands
			  (let ((a-command (car commands)))
			    (if (string= (nth 0 a-command)
					 (substring file (- (length (nth 0 a-command)))))
				(throw 'command t)))
			  (setq commands (cdr commands)))
			nil))))
    (if command-p
	(message "this is related to a command.")
      (let ((edit-buffer (find-file-noselect ange-file)))
	(if (car (nth 7 content))
	    (call-interactively (car (nth 7 content)))) ; XXX
	(postit-set-window-configuration 2 edit-buffer)))))

(defun postit-edit-memo ()
  (interactive)
  (let ((content (postit-assoc-content postit-current-location)))
    (if (equal '(nil) content)
	(message "There's no memo can be edited.")
      (cond ((eq 'text (car content))
	     (postit-edit-memo-text content))
	    ((eq 'ftp (car content))
	     (postit-edit-memo-ftp content))
	    ))))

;; postit-edit-mode
(defun postit-entry-register-aux () ;
  (set-buffer postit-edit-buffer)
  (goto-char (point-min))
  (let* ((headers (buffer-substring
		   (point)
		   (progn
		     (search-forward "--text follows this line--\n" nil t 1)
		     (forward-line -1)
		     (point))))
	 (title (progn
		  (string-match "^Title: \\(.*\\)$" headers)
		  (substring headers (match-beginning 1) (match-end 1))))
	 (subject (progn
		    (if (string-match "^Subject: \\(.*\\)$" headers)
			(substring headers (match-beginning 1) (match-end 1))
		      "")))
	 (memo (progn
		 (search-forward "--text follows this line--\n" nil t 1)
		 (buffer-substring (point) (point-max)))))
    (list title subject memo)))

(defun postit-entry-register ()
  "In editing a plain text, register the memo."
  (interactive)
  (let ((body (postit-entry-register-aux)) ; (title subject memo)
	(time (current-time)))
    (if postit-edit-or-make
	(postit-add-new-content (list 'text (nth 0 body) time (nth 1 body)
				      (nth 2 body) 1 t
				      (list major-mode)))
      (postit-set-new-content
       (list 'text (nth 0 body) time (nth 1 body) (nth 2 body)
	     (1+ (nth 5 (postit-assoc-content postit-current-location))) ; XXX 1+
	     t (list major-mode)))))
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (postit-set-window-configuration 1) ; 5 XXX
  (postit-show-titles))

(defun postit-entry-register-and-quit ()
  (interactive)
  (postit-entry-register)
  (postit-save)
  (postit-quit))

(defun postit-entry-register-and-save ()
  (interactive)
  (postit-entry-register)
  (postit-save))


;;; rename title mode
(defun postit-rename-title () ; WYSIWYG/at the point interface as possible
  (interactive)
  (let ((content (postit-assoc-content postit-current-location))
	(overlay (make-overlay (point-min) (point-min)))
	temp
	)
    (if (equal '(nil) content)
	(message "There's no memo.")
      (toggle-read-only 0)
      (put-text-property (point-min) (point) 'read-only t)
      (forward-char 1)
      (save-excursion
	(forward-line 1)
	(forward-char -1)
	(put-text-property (point) (point-max) 'read-only t))
      (delete-region (point) (progn (end-of-line) (point)))
      (setq temp (point))
      (insert (nth 1 content))
      (move-overlay overlay temp (point))
      (overlay-put overlay 'face 'highlight)
      (postit-rename-title-mode)
      )))

(defun postit-rename-title-set ()
  (interactive)
  (postit-goto-location postit-current-location)
  (forward-char 1) ; "|"
  (let* ((new-title (buffer-substring (point) (progn (end-of-line) (point))))
	 (content (postit-assoc-content postit-current-location))
;	 (new-content (postit-setq-nth 1 content new-title))
	 (new-content (append (list (nth 0 content) new-title)
			      (nthcdr 2 content)))
	 (inhibit-read-only t)
	 )
    (postit-set-new-content new-content)
    (remove-text-properties (point-min) (point-max) '(read-only))
    (postit-show-titles)
    (postit-mode)))

(defun postit-rename-title-cancel ()
  (interactive)
  (let ((inhibit-read-only t))
    (remove-text-properties (point-min) (point-max) '(read-only))
    (postit-show-titles)
    (postit-mode)))

(defvar postit-rename-title-mode-map nil)
(defvar postit-rename-title-mode-hook nil)
(or postit-rename-title-mode-map
    (progn
      (setq postit-rename-title-mode-map (make-sparse-keymap))
      (define-key postit-rename-title-mode-map [return] 'postit-rename-title-set)
      (define-key postit-rename-title-mode-map "\C-g" 'postit-rename-title-cancel)
      ))

(defun postit-rename-title-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'postit-rename-title-mode)
  (setq mode-name "Postit Rename Title")
  (use-local-map postit-rename-title-mode-map)
  (run-hooks 'postit-rename-title-mode-hook))

;;; functions for showing or closing contents, headers
(defun postit-url-click (event)
  (interactive "e")
  (let ((posn (event-start event)))
    (save-excursion
      (set-buffer (window-buffer (posn-window posn)))
      (goto-char (posn-point posn))
      (if (and (get-text-property (point) 'mouse-face)
	       (get-text-property (point) 'local-map)
	       (get-text-property (point) 'string))
	  (let ((url (get-text-property (point) 'string)))
	    (postit-fetch-url-by-netscape url))))))

(defun postit-url-make-clickable ()
  (goto-char (point-min))
  (while (re-search-forward postit-urls nil t 1)
    (let ((map (make-sparse-keymap)))
      (define-key map [mouse-2] 'postit-url-click)
      (put-text-property (match-beginning 0) (match-end 0)
			 'mouse-face 'highlight)
      (put-text-property (match-beginning 0) (match-end 0)
			 'face 'bold)
      (put-text-property (match-beginning 0) (match-end 0) 'local-map map)
      (put-text-property (match-beginning 0) (match-end 0) 'string
			 (buffer-substring (match-beginning 0) (match-end 0)))
      )))

; (defun postit-url-set-face ()
;   (goto-char (point-min))
;   (while (re-search-forward postit-urls nil t 1)
;     (put-text-property (match-beginning 0) (match-end 0)
; 		       'mouse-face 'highlight)))

;; window configuration sensitively
; 1. only titles
; 2. titles + (a) show (b) edit (c) search
; 3. titles + header
; 4. titles + show + header
; 5. restore the `postit-current-window-configuration'
(defun postit-set-window-configuration (which &optional show-buffer header-lines)
  "show-buffer is a buffer to be displayed:
postit-show-buffer or postit-edit-buffer or postit-search-buffer,
or postit-header-buffer.
header-lines is a height of header."
  (let* ((cur-win-buf-conf ; current-window-buffer-configuration
	  (let* ((current-window (frame-first-window))
		 (current-window-buffer (window-buffer current-window))
		 (list (list current-window-buffer)))
	    (while (not (eq current-window-buffer
			    (window-buffer (next-window current-window))))
	      (setq current-window (next-window current-window))
	      (setq list (cons (window-buffer current-window) list)))
	    (reverse list)))
	 (may-title-buffer (nth 0 cur-win-buf-conf)))
    (cond ((= 1 which)
	   (if (and (eq postit-title-buffer may-title-buffer)
		    (= 1 (length cur-win-buf-conf)))
	       ()
	     (delete-other-windows)
	     (switch-to-buffer postit-title-buffer)
	     (setq postit-current-window-configuration
		   (current-window-configuration))
	     (setq postit-showing-p nil)))
	  ((= 2 which)
	   (if (and (eq postit-title-buffer may-title-buffer)
		    (= 2 (length cur-win-buf-conf)))
	       (if show-buffer
		   (progn ; XXX
		     (other-window 1)
		     (switch-to-buffer show-buffer)
		     (other-window -1))
		 (or (eq postit-show-buffer (nth 1 cur-win-buf-conf)) ; XXX
		     (eq postit-edit-buffer (nth 1 cur-win-buf-conf))
		     (eq postit-search-buffer (nth 1 cur-win-buf-conf))))
	     (delete-other-windows)
	     (switch-to-buffer postit-title-buffer)
	     (split-window-vertically postit-window-split-value)
	     (other-window 1)
	     (switch-to-buffer show-buffer) ; show or edit or search
	     (other-window -1)
	     (setq postit-current-window-configuration
		   (current-window-configuration))))
	  ((= 3 which)
	   (postit-close-other-windows)
	   (split-window-vertically (- (window-height) header-lines))
	   (other-window 1)
	   (switch-to-buffer show-buffer)
	   (other-window -1))
	  )))

(defun postit-toggle-header () ; XXX
  (interactive)
  (let ((content (postit-assoc-content postit-current-location)))
    (if (equal '(nil) content)
	()
      (setq postit-showing-header-p (not postit-showing-header-p))
      (if postit-showing-header-p
	  (let ((header-buffer (progn
				 (kill-buffer (get-buffer-create postit-header-buffer-name))
				 (get-buffer-create postit-header-buffer-name))))
	    (set-buffer header-buffer)
	    (insert (concat "Title: " (nth 1 content) "\n"))
	    (insert (concat "Date: " (current-time-string (nth 2 content)) "\n"))
	    (toggle-read-only 1)
	    (postit-set-window-configuration 3 header-buffer 5))
	(postit-set-window-configuration 1)))))

(defun postit-show-content-aux-folder (mode content)
  (if (or (eq 'force mode)
	  (eq 'maybe mode))
      (progn
	(postit-toggle-folder-visible)
	(postit-setq-nth 5 content (1+ (nth 5 content))))))

(defun postit-show-content-aux-text (mode content)
  (cond ((and (equal postit-current-location postit-previous-location)
	      postit-showing-p
	      (eq 'maybe mode))
	 (scroll-other-window))
	((and (eq 'moving mode)
	      (not postit-showing-p))
	 ())
	((or (eq 'maybe mode)
	     (eq 'force mode)
	     (and (eq 'moving mode)
		  postit-showing-p))
	 (kill-buffer (get-buffer-create postit-show-buffer-name))
	 (setq postit-show-buffer (get-buffer-create postit-show-buffer-name))
	 (set-buffer postit-show-buffer)
	 (if (car (nth 7 content))
	     (call-interactively (car (nth 7 content)))) ; XXX
	 (insert (nth 4 content))
	 (postit-url-make-clickable)
;	 (postit-url-set-face)
	 (goto-char (point-min))
	 (toggle-read-only 1)
	 (postit-set-window-configuration 2 postit-show-buffer)
	 (setq postit-showing-p t)
	 (setq postit-previous-location postit-current-location)
	 (postit-setq-nth 5 content (1+ (nth 5 content)))
	 )))

(defun postit-show-content-aux-link (mode content)
  (let* ((file (expand-file-name (nth 4 content)))
	 (command (let ((result nil) (commands postit-link-commands))
		    (while (and commands (not result))
		      (let ((a-command (car commands)))
			(if (string= (nth 0 a-command)
				     (substring file (- (length (nth 0 a-command)))))
			    (setq result a-command)))
		      (setq commands (cdr commands)))
		    result)))
    (if (file-readable-p file)
	(if command
	    (cond ((or (eq 'force mode)
		       (and (eq 'maybe mode)
			    (not postit-showing-p)))
		   (apply 'start-process
			  (append (list (cadr command)
					postit-process-buffer-name
					(cadr command) file)
				  (cddr command))) ; options
		   (message "started process %s" (cadr command))
		   (postit-setq-nth 5 content (1+ (nth 5 content))))
		  ((or (eq 'moving mode)
		       (and (eq 'maybe mode) postit-showing-p))
		   ()))
	  (if (and (equal postit-current-location postit-previous-location)
		   postit-showing-p
		   (eq 'maybe mode))
	      (scroll-other-window)
	    (let ((file-buffer (find-file-noselect file)))
	      (postit-set-window-configuration 2 file-buffer)
	      (setq postit-showing-p t)
	      (setq postit-previous-location postit-current-location)
	      (postit-setq-nth 5 content (1+ (nth 5 content))))
	    ))
      (message "Can't read the file: %s" file))))

(defun postit-show-content-aux-ftp (mode content) ; ange-ftp is obsolete XXX
  (let* ((file (nth 2 (nth 4 content)))
	 (ange-file (concat "/" (nth 1 (nth 4 content)) ; user
			    "@"
			    (nth 0 (nth 4 content)) ; host
			    ":" file))
	 (command (let ((result nil) (commands postit-link-commands))
		    (while (and commands (not result))
		      (let ((a-command (car commands)))
			(if (string= (nth 0 a-command)
				     (substring file (- (length (nth 0 a-command)))))
			    (setq result a-command)))
		      (setq commands (cdr commands)))
		    result)))
    (cond ((or (eq 'force mode)
	       (and (eq 'maybe mode)
		    (not postit-showing-p)))
	   (if (ange-ftp-file-readable-p ange-file) ; XXX XXX XXX !!!!!!!!
	       (if command
		   () ; fetch the file and execute command XXX
		 (let ((file-buffer (find-file-noselect ange-file)))
		   (postit-set-window-configuration 2 file-buffer)
		   (setq postit-showing-p t)
		   (postit-setq-nth 5 content (1+ (nth 5 content)))))
	     (message "Can't read the file: %s" ange-file)))
	  ((or (eq 'moving mode)
	       (and (eq 'maybe mode) postit-showing-p))
	   ()))
    ))

(defun postit-show-content-aux-url (mode content)
  (cond ((or (eq 'force mode)
	     (and (eq 'maybe mode)
		  (not postit-showing-p)))
	 (let ((browser (if postit-browser
			    postit-browser
			  (nth 1 (nth 4 content)))))
	   (cond ((eq 'netscape browser)
		  (postit-fetch-url-by-netscape (nth 0 (nth 4 content))))
		 ((eq 'lynx browser)
		  (postit-fetch-url-by-lynx (nth 0 (nth 4 content))))
		 ((eq 'w3 browser)
		  (delete-other-windows)
		  (split-window-vertically postit-window-split-value)
		  (other-window 1)
		  (w3-fetch (nth 0 (nth 4 content)))
		  (other-window -1)
		  (setq postit-showing-p t)))))
	((or (eq 'moving mode)
	     (and (eq 'maybe mode)
		  postit-showing-p))
	 ())))

; (postit-setq-nth 5 content (1+ (nth 5 content)))) は関数にするべきだなあ
(defun postit-show-content (mode)
  (let ((content (postit-assoc-content postit-current-location)))
    (cond ((eq 'folder (car content))
	   (postit-show-content-aux-folder mode content))
	  ((eq 'text (car content))
	   (postit-show-content-aux-text mode content))
	  ((eq 'link (car content))
	   (postit-show-content-aux-link mode content))
	  ; ange-ftp-execute-command とかあるかなー？
	  ((eq 'ftp (car content))
	   (postit-show-content-aux-ftp mode content))
	  ((eq 'url (car content))
	   (postit-show-content-aux-url mode content))
	  )))

(defun postit-show-content-maybe ()
  (interactive)
  (postit-show-content 'maybe))

(defun postit-show-content-force ()
  (interactive)
  (postit-show-content 'force))

(defun postit-show-mouse-position (event)
  (interactive "e")
  (let* ((posn (event-start event))
	 (hit (save-excursion
		(set-buffer (window-buffer (posn-window posn)))
		(goto-char (posn-point posn))
		(if (get-text-property (point) 'mouse-face)
		    (let* ((line (- (postit-current-absolute-line) 2)) ; XXX
			   (location (assoc line postit-line-to-content-alist)))
		      location)
		  nil))))
    (if hit
	(progn
	  (postit-goto-location (cdr hit)) ; new location
	  (postit-show-content-force)))))

(defun postit-memo-backscroll ()
  (interactive)
  (and postit-showing-p
       (scroll-other-window-down nil)))

(defun postit-close-other-windows ()
  (interactive)
  (delete-other-windows)
  (setq postit-showing-p nil))

(defvar postit-search-count 0)
(defun postit-search-click (event)
  (interactive "e")
  (let ((posn (event-start event)))
    (save-excursion
      (set-buffer (window-buffer (posn-window posn)))
      (goto-char (posn-point posn))
      (if (and (get-text-property (point) 'mouse-face)
	       (get-text-property (point) 'local-map)
	       (get-text-property (point) 'location)
	       (get-text-property (point) 'number)
	       (get-text-property (point) 'string))
	  (let ((location (get-text-property (point) 'location))
		(string (get-text-property (point) 'string))
		(number (get-text-property (point) 'number)))
;	    (postit-show-titles) ; XXX
	    (set-buffer postit-title-buffer)
	    (postit-goto-location location) ; XXX
	    (postit-show-titles) ; XXX
	    (postit-show-content-force)
	    (set-buffer postit-show-buffer)
	    (search-forward string nil t number)
	    (set-window-point (get-buffer-window (current-buffer) 'visible)
			      (point)))))))

(defun postit-search-make-clickable (string location number)
  (let ((map (make-sparse-keymap)))
    (define-key map [mouse-2] 'postit-search-click)
    (add-text-properties 0 (length string) (list 'face 'bold
						 'mouse-face 'highlight
						 'local-map map
						 'location location
						 'number number
						 'string string)
			 string)
    string))

(defun postit-search-string-aux (location contents string)
  (while contents
    (let ((content (car contents)))
      (cond ((eq 'text (nth 0 content))
	     (let ((memo (nth 4 content))
		   (start 0)
		   (number 1))
	       (if (string-match (concat "^.*\\(" string "\\).*$") memo start)
		   (progn
		     (insert (concat (nth 1 content) "\n"))
		     (while (string-match (concat "^.*\\(" string "\\).*$")
					  memo start)
		       (setq postit-search-count (1+ postit-search-count))
		       (setq start (match-end 0))
		       (insert (concat (postit-search-make-clickable
					(substring memo (match-beginning 0)
						   (match-end 0))
					location number)
				       "\n")))
		     (insert "\n")))))
	    ((eq 'folder (nth 0 content))
	     (postit-search-string-aux (reverse (cons 1 (reverse location)))
				       (nth 4 content) string))
	    (t ; nil, link, ftp, url
	     ())))
    (setq location (postit-increment-last-1 location))
    (setq contents (cdr contents))))

(defun postit-search-string (string)
  (interactive "sSearch: ")
  (kill-buffer (get-buffer-create postit-search-buffer-name))
  (setq postit-search-buffer (get-buffer-create postit-search-buffer-name))
  (save-excursion
    (set-buffer postit-search-buffer)
    (setq postit-search-count 0)
    (postit-search-string-aux '(1) postit-contents string))
  (if (< 0 postit-search-count)
      (postit-set-window-configuration 2 postit-search-buffer))
  (message "Hit %d for `%s'" postit-search-count string))

;;; functions around initializing, terminating, and basis
(defun postit-make-header ()
  (insert "Postit version 1.3  by hiroki-t@is.aist-nara.ac.jp\n(nil)(nil)"))

(defun postit-check-variables () ; XXX
  ())

(defun postit-check-contents (contents)
  (if (equal '(nil) contents)
      t
    (let ((bool t))
      (while (and contents
		  bool)
	(let* ((content (car contents))
	       (category (car content)))
	  (if (and (stringp (nth 1 content)) ; title
		   (= 3 (length (nth 2 content))) ; date
		   (stringp (nth 3 content)) ; subject
		   (integerp (nth 5 content)) ; visit-frequency
		   (or (eq t (nth 6 content))
		       (eq nil (nth 6 content))) ; visibility
		   )
	      (cond ((eq 'folder category)
		     (setq bool (and (postit-check-contents (nth 4 content))
				     (or (eq t (nth 7 content)) ; content-visib
					 (eq nil (nth 7 content)))
				     (or (eq t (nth 8 content)) ; cntnt-tmp-vis
					 (eq nil (nth 8 content)))
				     (or (null (nth 9 content)) ; last-visited
					 (integerp (nth 9 content))))))
		    ((or (eq 'text category) (eq 'link category))
		     (setq bool (and (stringp (nth 4 content))
				     (listp (nth 7 content)))))
		    ((eq 'ftp category)
		     (setq bool (and (= 3 (length (nth 4 content)));hst,usr,fil
				     (listp (nth 7 content)))))
		    ((eq 'url category)
		     (setq bool (and (listp (nth 4 content))
				     (listp (nth 7 content)))))
		    )
	    (setq bool nil)))
	(setq contents (cdr contents)))
      bool)))

(defun postit-load ()
  (if postit-contents
      t
    (mapcar (lambda (buffer)
	      (kill-buffer (get-buffer-create buffer)))
	    (list postit-buffer-name postit-title-buffer-name
		  postit-show-buffer-name postit-header-buffer-name
		  postit-edit-buffer-name postit-search-buffer-name
		  postit-process-buffer-name postit-sub-process-buffer-name))
    (setq postit-buffer (get-buffer-create postit-buffer-name))
    (set-buffer postit-buffer)
    (let* ((file (expand-file-name postit-file))
	   (compressed-file (concat file (nth 2 postit-compress-commands))))
      (if (and postit-compress-commands
	       (file-exists-p compressed-file))
	  (apply 'call-process (append (list (nth 3 postit-compress-commands)
					     nil;compressed-file
					     t
					     nil)
				       (nth 4 postit-compress-commands)
				       (list compressed-file)))
	(if (file-exists-p file)
	    (insert-file-contents-literally file)
	  (postit-make-header))) ; the first invocation, make header.
      (beginning-of-buffer)
      (if (re-search-forward "Postit version 1\\..  by hiroki-t@is.aist-nara.ac.jp\n" nil t)
			;;(buffer-substring (point-min) (+ (point-min) 51)))
	  ;;(buffer-substring (point-min) (point-max)))
	  (progn
	    (cond ((featurep 'mule)
		   (cond ((string-match "^19" emacs-version) ; mule19
			  (code-convert-region (point-min) (point-max)
					       *autoconv* *internal*))
			 ((featurep 'xemacs) ; xemacs
			  (decode-coding-region (point-min) (point-max)
						'no-conversion))
			 ((string-match "^20" emacs-version)
			  (decode-coding-region (point-min) (point-max)
						'emacs-mule))
			 ((string-match "^21" emacs-version)
			  (decode-coding-region (point-min) (point-max)
						'emacs-mule))
			 )))
	    (re-search-forward "Postit version 1\\..  by hiroki-t@is.aist-nara.ac.jp\n")
	    (setq postit-current-location (read (current-buffer)))
;	  (setq postit-previous-location postit-current-location) ; XXX
	    (setq postit-contents (read (current-buffer)))
	    (if (postit-check-contents postit-contents)
		(progn
		  (message "Loaded postit file.")
		  t)
	      (message "Checking postit file failed.")
	      nil))
	(message "Incorrect postit file.")
	(kill-buffer postit-buffer)
	nil))))

; (defun postit-add-color (memo)
;   (and window-system postit-colorize
;        (let ((category (nth 0 memo))
; 	     (title (nth 1 memo))
; 	     (date (nth 2 memo))
; 	     (subject (nth 3 memo)))
; 	 (add-text-properties 0 (length title)
; 			      '(face postit-title-face) title)
; ; 	 (add-text-properties 0 (length date)
; ; 			      '(face postit-date-face) date)
; 	 (add-text-properties 0 (length category)
; 			      '(face postit-category-face) category)
; 	 (append (list category title date subject)
; 		 (nthcdr 4 memo)))))

(defun postit-add-color (string face) ; ??
  (if (and window-system postit-colorize)
      (progn
	(remove-text-properties 0 (length string) '(read-only face) string)
	(add-text-properties 0 (length string) (list 'face face) string)))
  string)

(defun postit-add-highlight (string)
  (if (and window-system)
      (add-text-properties 0 (length string) (list 'mouse-face 'highlight)
			   string))
  string)

(defun postit-truncate-string (string limit)
  "Make (string-width string) = limit."
  (if (< (string-width string) limit)
      (concat string (make-string (- limit (string-width string)) ? ))
    (while (> (string-width string) limit)
      (setq string (substring string 0 (1- (length string)))))
    (if (< (string-width string) limit)
	(concat string (make-string (- limit (string-width string)) ? ))
      string)))

(defun postit-show-titles-arrange-headers (memo depth)
  (let ((category (nth 0 memo))
	(title (postit-truncate-string
		(postit-add-highlight
		 (postit-add-color (if (string= "" (nth 1 memo))
				       "(no title)"
				     (copy-sequence (nth 1 memo)))
				   'postit-title-face))
		(- 36 depth)))
	(date (nth 2 memo))
	(subject (nth 3 memo))
	(content (nth 4 memo)))
    (concat (make-string depth ? )
	    (if (eq 'folder category)
		(if (or postit-always-show-all-entry (nth 7 memo) (nth 8 memo))
		    "-" "+")
	      "|")
	    title
	    (cond ((eq 'link category)
		   (postit-truncate-string
		    (postit-add-color (copy-sequence content)
				      'postit-link-face)
		    24))
		  ((eq 'ftp category)
		   (postit-truncate-string
		    (postit-add-color (concat (nth 0 content)
					      ":"
					      (nth 2 content))
				      'postit-ftp-face)
		    24))
		  ((eq 'url category)
		   (postit-truncate-string
		    (postit-add-color (copy-sequence (car content))
				      'postit-url-face)
		    24))
		  (t ; text
		   (postit-add-color (current-time-string date)
				     'postit-time-face)))
	    " "
;	    (symbol-name category)
	    (postit-add-color (concat (symbol-name category) "") ; XXX why ???
			      'postit-category-face)
	    "\n")))

(defun postit-show-titles-aux (contents depth parent-visibility)
  (if (equal '(nil) contents)
      (let ((index (concat (make-string depth ? ) "\n")))
	(if (or postit-always-show-all-entry parent-visibility)
	    ()
	  (add-text-properties 0 (length index) '(invisible t) index))
	(insert index))
    (while contents
      (let* ((memo (car contents))
	     (category (nth 0 memo))
	     (index (postit-show-titles-arrange-headers memo depth))
	     (visibility (nth 6 memo)))
	(if (or postit-always-show-all-entry
		(and parent-visibility visibility))
	    ()
	  (add-text-properties 0 (length index) '(invisible t) index))
	(insert index)
	(cond ((eq category 'folder)
	       (let ((contents (nth 4 memo))
		     (contents-visibility (or (nth 7 memo) (nth 8 memo))))
		 (postit-show-titles-aux contents (+ 2 depth)
					 (and parent-visibility visibility
					      contents-visibility))))
	      (t
	       ())))
      (setq contents (cdr contents)))))

(defun postit-show-titles ()
  (postit-make-line-to-content-alist)
  (postit-make-content-to-line-alist)
  (setq postit-title-buffer (get-buffer-create postit-title-buffer-name))
  (set-buffer postit-title-buffer)
  (toggle-read-only 0)
  (erase-buffer)
  (insert "Postit v1.3  - tiny memoranda -    by Tamakoshi(hiroki-t@is.aist-nara.ac.jp)\n")
  (insert " Title                               Update time / Link / URL Category\n")
  (postit-show-titles-aux postit-contents 0 t)
  (toggle-read-only 1)
  (switch-to-buffer postit-title-buffer)
  (postit-goto-location postit-current-location))

(defun postit-backup ()
  (if (and (not (null postit-file-backup-level)) ; 0, integer not float ... XXX
	   (integerp postit-file-backup-level))
      (let ((n postit-file-backup-level)
	    (file-u (expand-file-name postit-file))
	    (backup-file-u
	     (expand-file-name (concat postit-file-backup-directory
				       (file-name-nondirectory postit-file)))))
	(while (< 0 n)
	  (let ((backup-file-u-from
		 (concat backup-file-u
			 (if (= 1 n) ""
			   (concat "-" (int-to-string (1- n))))))
		(backup-file-u-to
		 (concat backup-file-u "-" (int-to-string n))))
	    (if postit-compress-commands
		(let ((backup-file-z-from (concat backup-file-u-from
						  (nth 2 postit-compress-commands)))
		      (backup-file-z-to (concat backup-file-u-to
						(nth 2 postit-compress-commands))))
		  (if (file-exists-p backup-file-z-from)
		      (call-process "mv" nil nil nil
				    backup-file-z-from backup-file-z-to)))
	      (if (file-exists-p backup-file-u-from)
		  (call-process "mv" nil nil nil
				backup-file-u-from backup-file-u-to))))
	  (setq n (1- n))))))

(defun postit-save ()
  (interactive)
  (message "Now saving...")
  (if postit-self-organize
      (postit-sort-by-access-count))
  (kill-buffer (get-buffer-create postit-buffer-name))
  (setq postit-buffer (get-buffer-create postit-buffer-name))
  (set-buffer postit-buffer)
  (insert "Postit version 1.3  by hiroki-t@is.aist-nara.ac.jp\n")
  (insert (concat (prin1-to-string postit-current-location) "\n"))
;   (insert (pp-to-string (postit-brushup-contents postit-contents)))
  (insert (prin1-to-string postit-contents))
;   (insert (postit-contents-to-string postit-contents 0))
  (postit-backup)
  (let ((file-u (expand-file-name postit-file)))
    (cond ((featurep 'mule)
	   (cond ((string-match "^19" emacs-version) ; mule19
		  (let ((orig-coding-system file-coding-system))
		    (setq file-coding-system *internal*)
		    (write-region (point-min) (point-max) file-u)
		    (setq file-coding-system orig-coding-system)))
		 ((featurep 'xemacs) ; xemacs
		  (let ((coding-system-for-write 'no-conversion))
		    (write-region (point-min) (point-max) file-u)))
		 ((string-match "^20" emacs-version) ; emacs20
		  (let ((coding-system-for-write 'emacs-mule))
		    (write-region (point-min) (point-max) file-u)))
		 ((string-match "^21" emacs-version) ; emacs20
		  (let ((coding-system-for-write 'emacs-mule))
		    (write-region (point-min) (point-max) file-u)))
		 )))
    (let ((mode 0)
	  (n (length postit-file-mode-string))
	  (c 0))
      (while (/= c n)
	(setq mode (+ (* mode 8)
		      (string-to-int (substring postit-file-mode-string
						c (1+ c)))))
	(setq c (1+ c)))
      (set-file-modes file-u mode)
      )
    (if postit-compress-commands
	(let ((file-z (concat file-u (nth 2 postit-compress-commands))))
	  (if (file-exists-p file-z)
	      (delete-file file-z))
	  (cond ((string= "gzip" (nth 0 postit-compress-commands))
		 (apply 'call-process
			(append (list (nth 0 postit-compress-commands)
				      nil nil nil)
				(nth 1 postit-compress-commands)
				(list file-u))))
		))))) ; and move compressed file-u to file-z ???

(defun postit-quit ()
  "Quit from postit."
  (interactive)
  (kill-buffer (get-buffer-create postit-buffer-name))
  (kill-buffer (get-buffer-create postit-title-buffer-name))
  (kill-buffer (get-buffer-create postit-show-buffer-name))
  (kill-buffer (get-buffer-create postit-edit-buffer-name))
  (kill-buffer (get-buffer-create postit-header-buffer-name))
  (kill-buffer (get-buffer-create postit-search-buffer-name))
  (kill-buffer (get-buffer-create postit-process-buffer-name))
  (kill-buffer (get-buffer-create postit-sub-process-buffer-name))
  (while postit-save-files
    (delete-file (car postit-save-files))
    (setq postit-save-files (cdr postit-save-files)))
  (set-window-configuration postit-previous-window-configuration)
  (setq postit-contents nil
	postit-showing-p nil
	postit-showing-header-p nil
	postit-previous-window-configuration nil
	postit-has-already-started nil
	)
  )

(defun postit-save-and-quit ()
  (interactive)
  (postit-save)
  (postit-quit))

(defun postit-mode ()
  "*Major mode for `postit'.

Special commands:
\\{postit-mode-map}

Turning on `postit-mode' runs hook `postit-mode-hook'."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'postit-mode)
  (setq mode-name "Postit")
  (use-local-map postit-mode-map)
  (run-hooks 'postit-mode-hook))

(defun postit ()
  "Postit is a tiny memoranda has mush feature.

Postit can
 * not only make a plain text memo, but also
 * link to a file and show the content by invoking a command
   corresponding to the file
   (for example, xdvi for *.dvi, gv for *.ps, display for *.gif, etc...),
 * link to a file on remote hosts and show the content,
 * set a URL and invoke a browser(Netscape, w3, lynx, MMM, ...)."
  (interactive)
  (if postit-has-already-started
      (message "Postit has already started at somewhere."); to be visible
    (and (postit-load)
	 (progn
	   (setq postit-previous-window-configuration
		 (current-window-configuration))
	   (postit-show-titles)
	   (setq postit-has-already-started t)
	   (postit-mode)))))

(provide 'postit)

;; end of postit.el
