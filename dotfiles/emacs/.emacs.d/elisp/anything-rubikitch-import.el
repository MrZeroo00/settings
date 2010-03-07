;;;
;; $Id: 99anything.el,v 1.429 2009/02/24 11:20:18 rubikitch Exp $

;; URL: http://www.emacswiki.org/cgi-bin/wiki/download/RubikitchAnythingConfiguration
;; Site: http://www.emacswiki.org/cgi-bin/emacs/Anything

;; install-elisp.el is in the EmacsWiki.
;; http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el

;; This file is delimited by linkd tags.
;; http://www.emacswiki.org/cgi-bin/wiki/download/linkd.el

;; The definition of with-new-window is here. It depends on windows.el.
;; (@* "with-new-window definition")
;; copy from 29windows.el
(unless (fboundp 'with-new-window)
  ;; (install-elisp "http://www.gentei.org/~yuuji/software/windows.el")
  (require 'windows)
  (defun win:insert-config (idx)
    (let (i (vector win:configs))
      (setq i 1)
      (while (and (< i (1- (length vector)))
                  (aref vector i))
        (setq i (1+ i)))
      (assert (eq (aref vector i) nil))
      (while (< idx i)
        (win:copy-config  (- i 1) i)
        (setq i (1- i)))
      (aset win:configs idx nil)
      (aset win:names idx nil)
      (aset win:names-prefix idx "")
      (aset win:sizes idx nil)
      (aset win:buflists idx (make-vector win:buffer-depth-per-win nil))
      (aset win:points idx nil)))
  (defmacro with-new-window (&rest body)
    `(let ((i (win:find-new-window)))
       (win:store-config win:current-config)
       (win:insert-config i)
       (win:switch-window i nil t)
       (delete-other-windows)
       ,@body
       (win:store-config i)))
  (defun win:squeeze-config ()
    (interactive)
    (let (idxs j k (limit win-rotate-by))
      (setq j 1)
      (while (<= j limit)
        (when (aref win:configs j)
          (setq  idxs (cons j idxs)))
        (and (eq j win:current-config) (setq win:current-config (length idxs)))
        (and (eq j win:last-config) (setq win:last-config (length idxs)))
        (setq j (1+ j)))
      (setq idxs (reverse idxs))

      (setq j 1)
      (mapcar (lambda (k)
                (win:copy-config k j)
                (setq j (1+ j)))
              idxs)
      (setq k j)
      (while (<= k limit)
        (aset win:configs k nil)
        (aset win:names k nil)
        (aset win:names-prefix k "")
        (aset win:sizes k nil)
        (aset win:buflists k (make-vector win:buffer-depth-per-win nil))
        (aset win:points k nil)
        (setq k (1+ k))
        )
      (win:store-config win:current-config)
      ))
  )


(define-key anything-map "Y" 'anything-yank-selection)

;; [2007/12/25] (@* "action extension")
(defun anything-c-action-replace (source new-action)
  (setf (cdr (assq 'action (symbol-value source))) new-action)
  (symbol-value source))

(defun anything-c-action-extend (description function)
  `((,(concat description " (new window)") . (lambda (c) (with-new-window (,function c))))
    (,description . ,function)
    (,(concat description " (other window)") . (lambda (c)
                                                 (when (one-window-p)
                                                   (select-window (split-window)))
                                                 (,function c)))))

(anything-c-action-replace
 'anything-c-source-man-pages
 (anything-c-action-extend "Show with Woman" 'woman))

;; (anything 'anything-c-source-man-pages)


;; [2008/10/15]
(defun anything-yank-selection ()
  (interactive)
  (delete-minibuffer-contents)
  (insert (anything-get-selection)))

(define-key anything-map "\C-r" 'anything-call-source-from-anything)

;; (@* " directory-files")
(defun anything-c-transform-file-name-nondirectory (files)
  (mapcar (lambda (f) (cons (file-name-nondirectory f) f)) files))
(defun anything-c-source-files-in-dir (desc dir &optional match skip-opened-file)
  `((name . ,desc)
    (candidates . (lambda () (directory-files ,dir t ,match)))
    (candidate-transformer
     . (lambda (candidates)
         (anything-c-compose (list candidates)
                             '(,@(if skip-opened-file (list 'anything-c-skip-opened-files))
                               anything-c-transform-file-name-nondirectory))))
    (type . file)))

;; (@* "  elinit")
(setq anything-c-source-elinit
      (anything-c-source-files-in-dir
       "Emacs init files" "~/.emacs.d/conf/" "^_?[0-9]+.+\.el$"))
;; (anything 'anything-c-source-elinit)


;; [2008/01/14] helper
(defun anything-c-create-format-commands-with-description (alist)
  (loop for (cmd . desc) in alist
        collect (cons (format "%s: %s" cmd desc) cmd)))

;; [2008/01/14] (@* " commands for current buffer")
(defvar anything-c-commands-for-current-buffer
  (anything-c-create-format-commands-with-description
   '(;; column-marker
     ("column-marker-1" . "Highlight column with green")
     ("column-marker-2" . "Highlight column with blue")
     ("column-marker-3" . "Highlight column with red")
     ("column-marker-turn-off-all" . "Remove all highlight by column-marker")

     ;; markerpen
     ("markerpen-clear-all-marks" . "Clear all markerpens")
     ("markerpen-clear-region" . "Clear markerpen of region")
     ("markerpen-mark-region-1" . "Highlight region with color")
     ("markerpen-mark-region-2" . "Highlight region with color")
     ("markerpen-mark-region-3" . "Highlight region with color")
     ("markerpen-mark-region-4" . "Highlight region with color")
     ("markerpen-mark-region-5" . "Highlight region with color")
     ("markerpen-mark-region-6" . "Highlight region with color")
     ("markerpen-mark-region-7" . "Highlight region with color")
     ("markerpen-mark-region-8" . "Highlight region with color")
     ("markerpen-mark-region-9" . "Highlight region with color")
     ("markerpen-mark-region-10" . "Highlight region with color")

     )))
  
(defvar anything-c-source-commands-for-current-buffer
  '((name . "Commands for current buffer")
    (candidates . anything-c-commands-for-current-buffer)
    (type . command)))

;; [2008/01/14] (@* " commands for insertion")
(defvar anything-c-commands-for-current-insertion
  (anything-c-create-format-commands-with-description
   '()))
(defvar anything-c-source-commands-for-insertion
  '((name . "Commands for current buffer")
    (candidates . anything-c-commands-for-current-insertion)
    (type . command)))

;; [2008/02/04] (@* "special-display-buffer-history")
(defvar anything-c-source-special-display-buffer-history
  '((name . "Special Display Buffer History")
    (candidates
     . (lambda () (remove-if-not #'get-buffer special-display-buffer-history)))
    (action . display-buffer)))
;; (anything 'anything-c-source-special-display-buffer-history)

(defvar anything-c-source-w3m-defun
  '((name . "w3m DEFUN")
    (headline . "^DEFUN")
    (condition . (string-match "/w3m.+\.c$" (or buffer-file-name "")))))
;; (anything 'anything-c-source-w3m-defun)

(defvar anything-c-source-hatena-headline
  '((name . "Hatena HeadLine")
    (headline . "^\\*+")
    (migemo)
    (condition . (string-match "/memo/hatena/" (or buffer-file-name "")))))
;; (anything 'anything-c-source-hatena-headline)

(defvar anything-c-source-eev-anchor
  '((name . "Anchors!")
    (headline . (lambda () (format ee-anchor-format "\\(.+\\)")))
    (subexp . 1)))
;; (anything 'anything-c-source-eev-anchor)
;; [2008/08/12] <<< not-yet>>
(defvar anything-c-source-not-yet
  '((name . "Not Yet")
    (headline . "^# X.+$")
    (migemo)
    (condition . (string-match "index.e$" (or buffer-file-name "")))
    (adjust)
    (recenter)))
;; (anything 'anything-c-source-not-yet)

(setq anything-headline-sources
      '(anything-c-source-org-headline anything-c-source-oddmuse-headline
                                       anything-c-source-emacs-lisp-toplevels
                                       anything-c-source-rd-headline
                                       anything-c-source-w3m-defun
                                       anything-c-source-hatena-headline
                                       anything-c-source-emacs-source-defun
                                       anything-c-source-emacs-lisp-expectations))


;; [2008/09/02] (@* " background")
(defvar anything-c-source-background
  '((name . "Background")
    (candidates . anything-c-background-candidates)
    (action . pop-to-buffer)))
(defun anything-c-background-candidates ()
  (loop for b in (buffer-list)
        for name = (buffer-name b)
        when (string-match "^%" name)
        collecting
        (cons (with-current-buffer b
                (goto-char (point-min))
                (concat "Background: " (buffer-substring-no-properties (+ (point-min) 10) (point-at-eol))))
              name)))
;; (anything 'anything-c-source-background)
;; (anything '(((name . "test")(candidates ("hoge" . "boke")))))

(defvar anything-c-source-cheat
  '((name . "Cheat Sheets")
    (init . (lambda ()
              (unless (anything-candidate-buffer)
                (with-current-buffer (anything-candidate-buffer 'global)
                  (call-process-shell-command
                   "cheat sheets" nil  (current-buffer))
                  (goto-char (point-min))
                  (forward-line 1)
                  (delete-region (point-min) (point))
                  (indent-region (point) (point-max) -2)))))
    (requires-pattern)
    (candidates-in-buffer)
    (action . (lambda (entry)
                (let ((buf (format "*cheat sheet:%s*" entry)))
                  (unless (get-buffer buf)
                    (call-process "cheat" nil (get-buffer-create buf) t entry))
                  (display-buffer buf)
                  (set-window-start (get-buffer-window buf) 1))))))
;; (anything 'anything-c-source-cheat)


;; (@* "anything-grep fallback")
(defvar anything-c-source-anything-grep-fallback
  '((name . "anything-grep fallback")
    (dummy)
    (action . (lambda (query) (anything-grep-by-name nil query)))))
;; (anything 'anything-c-source-anything-grep-fallback)

;; (@* "google fallback")
(defvar anything-c-source-anything-google-fallback
  '((name . "Google fallback")
    (dummy)
    (action . google)))
;; (anything 'anything-c-source-anything-google-fallback)


;; (@* "kill-ring")
(setq anything-kill-ring-threshold 1)


;; [2009/01/08]
(defun anything-c-kill-ring-action (str)
  (setq kill-ring (delete str kill-ring))
  (if (not (eq (anything-attr 'last-command) 'yank))
      (insert-for-yank str)
    ;; from `yank-pop'
    (let ((inhibit-read-only t)
          (before (< (point) (mark t))))
      (if before
          (funcall (or yank-undo-function 'delete-region) (point) (mark t))
        (funcall (or yank-undo-function 'delete-region) (mark t) (point)))
      (setq yank-undo-function nil)
      (set-marker (mark-marker) (point) (current-buffer))
      (insert-for-yank str)
      ;; Set the window start back where it was in the yank command,
      ;; if possible.
      (set-window-start (selected-window) yank-window-start t)
      (if before
          ;; This is like exchange-point-and-mark, but doesn't activate the mark.
          ;; It is cleaner to avoid activation, even though the command
          ;; loop would deactivate the mark because we inserted text.
          (goto-char (prog1 (mark t)
                       (set-marker (mark-marker) (point) (current-buffer)))))))
  (kill-new str))

;; (@* "emacswiki pages") [2008/10/21]
;; I no longer use oddmuse.el.
' (defvar anything-c-source-emacswiki-pages
    '((name . "EmacsWiki")
      (init . (lambda () (oddmuse-make-completion-table "EmacsWiki")))
      (candidates
       . (lambda () (gethash "EmacsWiki" oddmuse-pages-hash)))
      (action
       ("open EmacsWiki page" . (lambda (candidate)
                                  (with-new-window
                                   (oddmuse-edit "EmacsWiki" candidate)
                                   (delete-other-windows))))
       ("open EmacsWiki page" . (lambda (candidate)
                                  (oddmuse-edit "EmacsWiki" candidate))))
      (persistent-action
       . (lambda (candidate)
           (oddmuse-edit "EmacsWiki" candidate)))))

;; (anything 'anything-c-source-emacswiki-pages)

;; (@* "call tree") [2008/10/21]
(defvar anything-c-source-simple-call-tree-functions-callers
  '((name . "Function is called by")
    (init
     . (lambda ()
         (require 'simple-call-tree)
         (when (anything-current-buffer-is-modified)
           (simple-call-tree-analyze)
           (let ((list (simple-call-tree-invert simple-call-tree-alist)))
             (with-current-buffer (anything-candidate-buffer 'local)
               (dolist (entry list)
                 (let ((callers (mapconcat #'identity (cdr entry) ", ")))
                   (insert (car entry) " is called by "
                           (if (string= callers "")
                               "no functions."
                             callers)
                           ".\n"))))))))
    (delayed)
    (candidates-in-buffer)))
;; (anything 'anything-c-source-simple-call-tree-functions-callers)
(defvar anything-c-source-simple-call-tree-callers-functions
  '((name . "Function calls")
    (init
     . (lambda ()
         (require 'simple-call-tree)
         (when (anything-current-buffer-is-modified)
           (simple-call-tree-analyze)
           (let ((list simple-call-tree-alist))
             (with-current-buffer (anything-candidate-buffer 'local)
               (dolist (entry list)
                 (let ((functions (mapconcat #'identity (cdr entry) ", ")))
                   (insert (car entry) " calls "
                           (if (string= functions "")
                               "no functions"
                             functions)
                           ".\n"))))))))
    (delayed)
    (candidates-in-buffer)))
;; (anything 'anything-c-source-simple-call-tree-callers-functions)

(defvar anything-c-source-windows-select
  '((name . "windows.el")
    (configs . 20)
    (init . (lambda () (win:switch-window win:current-config)))
    (candidates
     . (lambda ()
         (loop for i from 1 to (anything-attr 'configs)
               for key = (+ win:base-key i)
               for name-prefix = (aref win:names-prefix i)
               for name = (aref win:names i)
               when (and name (aref win:configs i))
               collecting (cons (format "[%c]%s:%s" key name-prefix name) i))))
    (action
     ("select" .
      (lambda (n)
        (cond ((aref win:configs (1+ win:current-config))
               (win:switch-window (1+ win:current-config))
               (unless (= win:current-config n) (win-swap-with (+ win:base-key n))))
              (t
               (let ((cc win:current-config))
                 (win:switch-window (1+ cc) nil t)
                 (win:set-wc n)
                 (win:switch-window n)
                 (win-delete-current-window nil)
                 (win:squeeze-config)
                 (win:switch-window cc)
                 (win-tab-updater)))))))))
;; (anything 'anything-c-source-windows-select)

;; (@* "buffer-list")
(defvar anything-c-source-buffer-list
  '((name . "Buffer List")
    (init
     . (lambda ()
         (setq abl-buffer-list (abl-buffer-list)
               abl-candidates (abl-format-buffer-list abl-buffer-list))))
    (candidates . abl-candidates)
    (multiline)
    (sort-by)
    (volatile)
    (persistent-action
     . (lambda (item)
         (kill-buffer item)
         (anything-delete-current-selection)
         (message "Buffer <%s> Killed" item)))))
(defvar abl-buffer-list nil)
(defvar abl-candidates nil)

(defun abl-sort-func-key (symbol)
  (case symbol
    ('name '(string< car))
    ('size '(> cadr))
    ('mode '(string< caddr))))
(defun abl-sort-by (key)
  (anything-attrset 'sort-by key)
  (setq abl-candidates
        (abl-format-buffer-list 
         (destructuring-bind (func key) (abl-sort-func-key key)
           (if func
               (sort* abl-buffer-list func :key key)
             abl-buffer-list))))
  (anything-update))

(defun abl-sort-by-size ()
  (interactive)
  (abl-sort-by 'size))
(defun abl-sort-by-name ()
  (interactive)
  (abl-sort-by 'name))
(defun abl-sort-by-mode ()
  (interactive)
  (abl-sort-by 'mode))

(defun abl-buffer-list ()
  (mapcar (lambda (b)
            (list (buffer-name b)
                  (buffer-size b)
                  (buffer-local-value 'mode-name b)
                  (buffer-file-name b)))
          (buffer-list)))

(defun abl-format-buffer-list (blist)
  (loop for (name size mode file-name) in blist
        collect
        (cons (concat (format "%-40s %8d bytes <%s>"
                              name size mode)
                      (if file-name (format "\n  %s" file-name)))
              name)))

(defvar anything-buffer-list-map
  (let ((map (copy-keymap anything-map)))
    (define-key map "S" 'abl-sort-by-size)
    (define-key map "N" 'abl-sort-by-name)
    (define-key map "M" 'abl-sort-by-mode)
    map))

(defun anything-buffer-list ()
  (interactive)
  (let ((anything-map anything-buffer-list-map)
        (anything-candidate-number-limit 9999))
    (define-key anything-map "S" 'abl-sort-by-size)
    (define-key anything-map "N" 'abl-sort-by-name)
    (define-key anything-map "M" 'abl-sort-by-mode)
    (anything 'anything-c-source-buffer-list)))


;; (anything 'anything-c-source-buffer-list)


;; (@* "org-gtd-started-waiting")
;(defvar anything-c-org-todo-states "^\\*+ \\<\\(STARTED\\|WAITING\\)\\> ")
(defvar anything-c-org-todo-states '("STARTED" "WAITING"))
(defvar anything-c-source-org-todo-state
  '((name . "Started and Waiting tasks")
    (candidates
     . (lambda ()
         (with-current-buffer (find-file-noselect org-default-notes-file)
           (loop for state in anything-c-org-todo-states
                 do (goto-char (point-min))
                 append
                 (loop while (re-search-forward (format "^\\*+ \\<%s\\> " state) nil t)
                       for bol = (point-at-bol)
                       collect (cons (buffer-substring bol (point-at-eol)) bol))))))
    (action
     ("Go to the location" . (lambda (p)
                               (find-file org-default-notes-file)
                               (goto-char p))))))
;; (anything 'anything-c-source-org-todo-state)

(add-to-list 'anything-c-source-org-todo-state
             '(action
               ("Go to the location"
                . (lambda (p)
                    (with-new-window (find-file org-default-notes-file))
                    (goto-char p)))))


;; (@* "new sources")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  (@* "type attribute helper")                                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar anything-type-attribute/command-local
  '((action 
     ("Call interactively" . anything-c-call-interactively)
     ("Call interactively" . anything-c-call-interactively)
     ("Describe Function" . alcs-describe-function))
    ;; Sort commands according to their usage count.
    ;;(filtered-candidate-transformer . anything-c-adaptive-sort)
    (persistent-action . alcs-describe-function)
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  (@* "type attributes")                                             ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (find-epp anything-type-attributes)
'(setq anything-type-attributes
      `((buffer
         (action
          ("Switch to Buffer (next curwin)" . win-switch-to-buffer)
          ("Switch to buffer" . switch-to-buffer)
          ("Switch to buffer other window" . switch-to-buffer-other-window)
          ("Kill buffer"      . kill-buffer)
          ("Switch to buffer other frame" . switch-to-buffer-other-frame)
          ("Display buffer"   . display-buffer))
         (candidate-transformer . (lambda (candidates)
                                    (anything-c-compose
                                     (list candidates)
                                     '(anything-c-skip-boring-buffers
                                       anything-c-skip-current-buffer
                                       anything-c-transform-navi2ch-article))))
         (persistent-action . switch-to-buffer))
        (file
         (action
          ("Find File (next curwin)" . win-find-file)
          ("Find file" . find-file)
          ("Find file other window" . find-file-other-window)
          ("Delete File" . anything-c-delete-file)
          ("Find file other frame" . find-file-other-frame)
          ("Open dired in file's directory" . anything-c-open-dired)
          ("Delete file" . anything-c-delete-file)
          ("Open file externally" . anything-c-open-file-externally)
          ("Open file with default tool" . anything-c-open-file-with-default-tool))
         (action-transformer . (lambda (actions candidate)
                                 (anything-c-compose
                                  (list actions candidate)
                                  '(anything-c-transform-file-load-el
                                    anything-c-transform-file-browse-url
                                    anything-c-transform-w3m-remote))))
         (candidate-transformer . (lambda (candidates)
                                    (anything-c-compose
                                     (list candidates)
                                     '(anything-c-skip-boring-files
                                       anything-c-shorten-home-path))))
         (persistent-action . find-file))
        (command-ext (action ("Call Interactively (new window)"
                              . (lambda (command-name)
                                  (with-new-window (anything-c-call-interactively command-name))))
                             ("Call interactively" . anything-c-call-interactively)
                             ("Describe command" . alcs-describe-function)
                             ("Add command to kill ring" . kill-new)
                             ("Go to command's definition" . alcs-find))
                     ;; Sort commands according to their usage count.
                     ;; (filtered-candidate-transformer . anything-c-adaptive-sort)
                     (persistent-action . alcs-describe-function)
                     )
        (command-local  ,@anything-type-attribute/command-local)
        (command  ,@anything-type-attribute/command-local)
        (function (action ("Describe function" . alcs-describe-function)
                          ("Add function to kill ring" . kill-new)
                          ("Go to function's definition" . alcs-find-function))
                  (action-transformer . (lambda (actions candidate)
                                          (anything-c-compose
                                           (list actions candidate)
                                           '(anything-c-transform-function-call-interactively)))))
        (sexp (action ("Eval s-expression" . (lambda (c)
                                               (eval (read c))))
                      ("Add s-expression to kill ring" . kill-new))
              (action-transformer . (lambda (actions candidate)
                                      (anything-c-compose
                                       (list actions candidate)
                                       '(anything-c-transform-sexp-eval-command-sexp)))))
        (escript (action ("Eval it" . anything-c-action-escript-eval)))
        (line (display-to-real . anything-c-display-to-real-line)
              (action ("Go to Line" . anything-c-action-line-goto)))
        (file-line (filtered-candidate-transformer . anything-c-filtered-candidate-transformer-file-line)
                   (multiline)
                   ;; (display-to-real . anything-c-display-to-real-file-line)
                   (action ("Go to (next curwin)"
                            . (lambda (file-line)
                                (with-new-window (anything-c-action-file-line-goto file-line))))
                           ("Go to" . anything-c-action-file-line-goto))
                   (action-transformer
                    . (lambda (actions sel)
                        (if (anything-attr-defined 'no-new-window)
                            (cdr actions)
                          actions)))
                   (persistent-action . anything-c-action-file-line-goto))
        (apropos-function
         (persistent-action . alcs-describe-function)
         (action
          ("Find Function (next window)"
           . (lambda (f) (with-new-window (alcs-find-function f))))
          ("Find Function" . alcs-find-function)
          ("Describe Function" . alcs-describe-function)
          ))
        (apropos-variable
         (persistent-action . alcs-describe-variable)
         (action
          ("Find Variable (next window)"
           . (lambda (v) (with-new-window (alcs-find-variable v))))
          ("Find Variable" . alcs-find-variable)
          ("Describe Variable" . alcs-describe-variable)))
        (complete-function
         (action . ac-insert)
         (persistent-action . alcs-describe-function))
        (complete-variable
         (action . ac-insert)
         (persistent-action . alcs-describe-variable))
        (complete
         (candidates-in-buffer . ac-candidates-in-buffer)
         (action . ac-insert))
        (bookmark
         (action
          ,@(anything-c-action-extend "Jump to Bookmark" 'bookmark-jump)
          ("Update Bookmark" . bookmark-set)
          ("Delete Bookmark" . bookmark-delete)
          ))
        ,@anything-type-attributes
        ))

(defun anything-c-transform-w3m-remote (actions candidate)
  (if (string-match "^h?ttp://" candidate)
      (cons '("w3m-remote" . w3mremote)
            actions)
    actions))

;; (@* "action function")
(defun anything-c-action-escript-eval (cand)
  (with-current-buffer (anything-candidate-buffer)
    (let ((max-mini-window-height
           (if anything-in-persistent-action 1 0.9)))
      (goto-char (point-min))
      (search-forward (concat cand "\n"))
      (eek-eval-last-sexp anything-current-prefix-arg))))



;; REDEFINED!
(defun alcs-describe-variable (v)
  (describe-hash-table (intern v)))


;; (@* "anything-set-source-filter")
(defvar anything-c-categories '(rubyref create))
(dolist (category anything-c-categories)
  (let ((funcsym (intern (format "anything-show/%s" category))))
    (eval `(defun ,funcsym ()
             (interactive)
             (anything-set-source-filter
              (mapcar (lambda (src) (assoc-default 'name src))
                      (remove-if-not (lambda (src) (memq ',category (assoc-default 'category src)))
                                     anything-sources)))))))

;; [2007/12/30] (@* "anything-insert-buffer-name")
(defun anything-insert-buffer-name ()
  (interactive)
  (delete-minibuffer-contents)
  (insert (with-current-buffer anything-current-buffer
            (if buffer-file-name (file-name-nondirectory buffer-file-name)
              (buffer-name)))))
;; [2007/12/30]
(defun anything-backward-char-or-show/create ()
  (interactive)
  (if (string= "" anything-pattern)
      (anything-show/create)
    (call-interactively 'backward-char)))
(defun anything-backward-char-or-insert-buffer-name ()
  (interactive)
  (if (string= "" anything-pattern)
      (anything-insert-buffer-name)
    (call-interactively 'backward-char)))

(defvar anything-function 'anything-at-point)

(defun anything-sort-sources-by-major-mode (sources)
  (loop for src in sources
        for modes = (anything-attr 'major-mode (symbol-value src))
        if (memq major-mode modes)
        collect src into prior
        else
        collect src into rest
        finally (return (append prior rest))))

;; [2008/09/21] (@* "anything default")
(defun anything-default ()
  (interactive)
  (let ((anything-input-idle-delay 0.2)
        (anything-idle-delay 0.7)
        (anything-quick-update t)
        (anything-sources
         (append
          '( ;;prior
             anything-c-source-mew-auto-refile-summary
             anything-c-source-rdefs-from-rdefs-buffer
             anything-c-source-emacs-variable-at-point
             anything-c-source-emacs-function-at-point
             anything-c-source-ffap-guesser
             ;;anything-c-source-files-in-current-dir/rtb
             anything-c-source-rake-task
             anything-c-source-tvavi
             ;;anything-c-source-buffers2
             anything-c-source-org-todo-state
             anything-c-source-windows-select
             anything-c-source-recentf
             anything-c-source-buffers
             anything-c-source-special-display-buffer-history
             anything-c-source-bookmarks
             anything-c-source-file-cache
             ;;anything-c-source-set-source-filter
             anything-c-source-elinit
             anything-c-source-switch-commands
             anything-c-source-background
             anything-c-source-cheat
             ;;anything-c-source-grep-buffer
             ;;anything-c-source-rtb
             anything-c-source-navi2ch-board
             )
          (anything-sort-sources-by-major-mode
           '(;; major-mode oriented sources
             anything-c-source-refe2x
             anything-c-source-ri
             anything-c-source-find-library
             anything-c-source-rubylib-18
             anything-c-source-rubylib-19
             anything-c-source-call-seq-ruby18
             anything-c-source-call-seq-ruby19
             anything-c-source-ruby18-source
             anything-c-source-ruby19-source
             anything-c-source-apropos-emacs-commands
             anything-c-source-apropos-emacs-functions
             anything-c-source-apropos-emacs-variables
             ;;anything-c-source-mysql-manual
             ))
          '(;; lower priority
             anything-c-source-ipa-global
             anything-c-source-info-pages
             ;;anything-c-source-man-pages
             ;;anything-c-source-extended-command-history
             anything-c-source-games
             anything-c-source-music
             ;;anything-c-source-faces
             ;;anything-c-source-colors
             anything-c-source-home-directory
             anything-c-source-compile-directory
             anything-c-source-auto-install-from-emacswiki
             anything-c-source-yaoddmuse-emacswiki-edit-or-view
             anything-c-source-file-name-history
             anything-c-source-anything-grep-fallback
             anything-c-source-anything-google-fallback
             ))))
    (call-interactively anything-function)))
;; [2008/01/04] (@* "anything for current-buffer")
(defvar anything-for-current-buffer-sources nil)
(defun anything-for-current-buffer ()
  (interactive)
  (let* ((anything-buffer "*anything current buffer*")
         (anything-sources
          (append
           '( ;; prior
             anything-c-source-not-yet
             anything-c-source-ipa
             anything-c-source-bm
             anything-c-source-fixme
             anything-c-source-linkd-tag
             anything-c-source-eev-anchor
             )
           anything-headline-sources
           '( ;; mode-oriented
             anything-c-source-rdefs
             anything-c-source-list-call-seq
             ;; minor
             anything-c-source-ctags
             ;;anything-c-source-imenu
             anything-c-source-commands-for-current-buffer
             anything-c-source-anything-grep-fallback
             anything-c-source-anything-google-fallback
             ;;anything-c-source-simple-call-tree-functions-callers
             ;;anything-c-source-simple-call-tree-callers-functions
             )))
         (anything-candidate-number-limit 2000))
    (call-interactively anything-function)))

;; [2008/01/12] (@* "anything for insert")
(defvar anything-for-insertion-sources nil)
(defun anything-for-insertion ()
  (interactive)
  (let* ((anything-buffer "*anything insert exec*")
         (anything-sources 
          '(anything-c-source-frequently-used-commands
            anything-c-source-kyr
            anything-c-source-extended-command-history
            anything-c-source-yasnippet
            anything-c-source-abbrev-local
            anything-c-source-abbrev-global
            ;;anything-c-source-rdefs
            anything-c-source-register
            anything-c-source-M-x
            anything-c-source-lacarte
            anything-c-source-commands-for-insertion
            anything-c-source-define-mode-abbrev
            anything-c-source-define-global-abbrev
            ))
         (anything-candidate-number-limit 200))
    (setq anything-current-prefix-arg current-prefix-arg)
    (anything)))

;; [2008/06/13] (@* "anything for langhelp")
;; temporary implementation
(defvar anything-for-langhelp-sources nil)
(defun anything-for-langhelp ()
  (interactive)
  (let ((anything-buffer "*anything langhelp*")
        (anything-sources '(anything-c-source-langhelp-ruby))
        (anything-candidate-number-limit 10000))
    (call-interactively anything-function)))

;; (@* "anything for create")
(defun anything-for-create-from-anything ()
  (interactive)
  (setq anything-input-idle-delay 0)
  (anything-set-sources
   '(((name . "Create")
      (dummy)
      (action
       ("find-file new window" . (lambda (x) (with-new-window (find-file x))))
       ("find-file" . find-file)
       ("find-file other window" . find-file-other-window)
       ("New buffer new window" . (lambda (x) (with-new-window (switch-to-buffer x))))
       ("New buffer" . switch-to-buffer)
       ("New buffer other window" . switch-to-buffer-other-window)
       ("YaSnippet on region"
        . (lambda (c)
                (with-stub
                  (let* ((mode-name (symbol-name anything-c-yas-cur-major-mode))
                         (root-dir (expand-file-name
                                    (if (listp yas/root-directory)
                                        (car yas/root-directory)
                                      yas/root-directory)))
                         (default-snippet-dir (anything-c-yas-find-recursively (symbol-name major-mode) root-dir 'dir))
                         (filename (concat default-snippet-dir "/" anything-input)))
                    (stub read-file-name => filename)
                    (anything-c-yas-create-new-snippet
                     (with-current-buffer anything-current-buffer
                       (if mark-active (buffer-substring-no-properties (region-beginning) (region-end)) "")))))))
       ("New Linkd Tag" . anything-c-insert-linkd-action)
       ("Bookmark Set" . bookmark-set)
       ("Define mode abbrev" . define-mode-abbrev-interactively)
       ("Define global abbrev" . define-abbrev-interactively)
       
      
;;                           anything-c-source-buffer-not-found
;;                           anything-c-source-insert-linkd-tag
;;                           anything-c-source-define-yasnippet-on-region
;;                           anything-c-source-bookmark-set
;;                           anything-c-source-define-mode-abbrev
;;                           anything-c-source-define-global-abbrev
;;                           anything-c-source-find-abbrev-file
                          )))))

;; (@* "anything for history") [2008/10/18] 
(defun anything-for-history ()
  (interactive)
  (anything-complete
   '(anything-c-source-kill-ring
     anything-c-source-complete-shell-history)
   ""))


;; [2008/01/15] (@* "abbrev or anything-for-insertion")
(defun expand-abbrev-or-anything-for-insertion ()
  (interactive)
  (or (and (not buffer-read-only) (expand-abbrev)) (anything-for-insertion)))

;; [2009/01/29]  (@* "disable pushy completion")
;; I do not want to do pushy completion with anything-related commands.
(dolist (cmd (all-completions "anything" obarray 'commandp))
  (put (intern cmd) 'pushy-completion 'disabled))

;(load "anything-private.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  (@* "sources")                                                     ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (emacswiki-post "RubikitchAnythingConfiguration")
;; Local Variables:
;; linkd-mode: t
;; End:
