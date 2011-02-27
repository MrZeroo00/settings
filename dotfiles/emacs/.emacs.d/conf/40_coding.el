;;;; indent
(setq-default tab-width 2)
;;;(setq tab-stop-list
;;;      '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;;;; http://d.hatena.ne.jp/mzp/20090620/indent
(my-require-and-when 'ky-indent
  (ky-indent-init)
  (setq ky-indent-regexp "src/")
  (setq ky-indent-exclude-regexp "~/svn/settings")
  )


;;;; paren
(show-paren-mode t)
;;;(setq show-paren-style 'mixed)
;;;(set-face-background 'show-paren-match-face "gray10")
;;;(set-face-foreground 'show-paren-match-face "SkyBlue")
;;;; mic-paren (highlight matching parenthesises)
;;;(install-elisp "http://user.it.uu.se/~mic/mic-paren.el")
(if window-system
    (progn
      (my-require-and-when 'mic-paren
  (paren-activate)                  ; activating
  (setq paren-match-face 'bold)
  (setq paren-sexp-mode t))
      ))


;;;; comment
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(setq comment-style 'multi-line)


;;;; debug
(my-require-and-when 'gud
  (setq gud-gdb-command-name "gdb -annotate=3")
  ;;(setq gud-chdir-before-run nil)
  (setq gud-tooltip-echo-area nil)
  (setq gdb-many-windows t)
  (setq gdb-use-separate-io-buffer t)

  (defun my-gdb-mode-hook ()
    (gud-tooltip-mode t))
  (add-hook 'gdb-mode-hook 'my-gdb-mode-hook)

  (when gdb-many-windows
    (defvar my-gud-window-configuration nil)
    (defun my-gud-save-window-configuration ()
      (setq my-gud-window-configuration (current-window-configuration)))
    (defun my-gud-restore-window-configuration ()
      (when (string-match " \*gud-.+" (buffer-name (current-buffer)))
        ;; gud-関係の場合
        (when (window-configuration-p my-gud-window-configuration)
          (set-window-configuration my-gud-window-configuration)
          (setq my-gud-window-configuration nil))))
    (add-hook 'gud-mode-hook 'my-gud-save-window-configuration)
    (add-hook 'kill-buffer-hook 'my-gud-restore-window-configuration))

  (defadvice gud-display-line
    (after raise-after-gud-display-line activate)
    (raise-frame (selected-frame))))


;;;; cedet
;;;; http://cedet.sourceforge.net/
'(my-load-and-when "~/local/share/emacs/site-lisp/cedet/common/cedet.el"
  (global-ede-mode 1)
;;;  (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")
  (semantic-load-enable-minimum-features)
  (semantic-load-enable-code-helpers)
;;;  (semantic-load-enable-gaudy-code-helpers)
;;;  (semantic-load-enable-all-exuberent-ctags-support)
;;;  (global-srecode-minor-mode 1)
  )


;;;; ecb
;;;; http://ecb.sourceforge.net/
;;;(my-require-and-when 'ecb-autoloads)


;;;; textmate
;;;(install-elisp "http://github.com/defunkt/textmate.el/raw/master/textmate.el")
'(my-require-and-when 'textmate
  (textmate-mode))


;;;; ctags
;;;(global-set-key "\M-t" 'find-tag)
;;;(global-set-key "\C-t" 'pop-tag-mark)
;;;(setq tags-table-list
;;;      '("~/src"))


;;;; gtags
;;;; http://tamacom.com/global-j.html
(my-autoload-and-when 'gtags-mode "gtags"
  	      (defun my-find-tag ()
  		(interactive)
  		(or (gtags-find-tag-from-here)
  		    (find-tag)))

  	      (setq gtags-mode-hook
  		    '(lambda ()
  		       ;;(my-load-and-when "_gtags-hack")
  		       (setq gtags-path-style 'root)
  		       (setq gtags-pop-delete nil)
             (if (memq major-mode '(gud-mode org-mode))
                 (define-key gtags-mode-map "\M-t" 'gtags-find-tag-other-window)
               (define-key gtags-mode-map "\M-t" 'gtags-find-tag-from-here))
  		       (define-key gtags-mode-map "\M-r" 'gtags-find-rtag)
  		       (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
  		       (define-key gtags-mode-map (kbd "\C-c t") 'gtags-pop-stack)
  		       ))

          (setq gtags-select-mode-hook
                '(lambda ()
                   (setq hl-line-face 'underline)
                   (hl-line-mode 1)))

          (defun my-gtags-update-single (file)
            (interactive
             (list (symbol-value 'buffer-file-name)))
            (when (memq major-mode '(c-mode c++-mode))
              (shell-command (concat "gtags_update_single " file))))
              ;;(start-process "my-gtags-update-process" "my-gtags-update-buffer" "gtags_update_single" file)))
          (defun my-gtags-update-single-for-current-file () (my-gtags-update-single (symbol-value 'buffer-file-name)))
          (add-hook 'after-save-hook 'my-gtags-update-single-for-current-file)
          )


;;;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=tagsfile%20maker
'(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))


;;;; imenu
(my-require-and-when 'imenu)


;;;; simple-call-tree
;;;(install-elisp-from-emacswiki "simple-call-tree.el")
;;;(my-require-and-when 'simple-call-tree)


;;;; speedbar
;;;(my-require-and-when 'speedbar)


;;;; which-func
(my-require-and-when 'which-func
  (which-func-mode t)

  (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
  (setq which-func-header-line-format
  '(which-func-mode
    ("" which-func-format
     )))
  (defadvice which-func-ff-hook (after header-line activate)
    (when which-func-mode
      (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
      (setq header-line-format which-func-header-line-format))))


;;;; smartchr
;;;(install-elisp "http://github.com/imakado/emacs-smartchr/raw/master/smartchr.el")
(my-require-and-when 'smartchr
  (global-set-key (kbd "=") (smartchr '(" = " " == " " === " "=")))
;;;  (global-set-key (kbd "{") (smartchr '("{ `!!' }" "{")))
;;;  (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
;;;  (global-set-key (kbd "F") (smartchr '("F" "$" "$_" "$_->" "@$")))
  )


;;;; brackets
;;;(install-elisp "http://www.mcl.chem.tohoku.ac.jp/~nakai/emacs/site-lisp/brackets.el")
(my-load-and-when "brackets")


;;;; doxymacs
(my-require-and-when 'doxymacs)


;;;; ediff
(my-require-and-when 'ediff
  (setq-default ediff-auto-refine-limit 10000)
  (setq ediff-split-window-function (lambda (&optional arg)
  			      (if (> (frame-width) 150)
  				  (split-window-horizontally arg)
  				(split-window-vertically arg))))

  (defun command-line-diff (switch)
    (let ((file1 (pop command-line-args-left))
    (file2 (pop command-line-args-left)))
      (ediff file1 file2)))
  (add-to-list 'command-switch-alist '("diff" . command-line-diff)))


;;;; test-case-mode
;;;(install-elisp "http://nschum.de/src/emacs/test-case-mode/test-case-mode.el")
(my-require-and-when 'test-case-mode
  (add-hook 'find-file-hook 'enable-test-case-mode-if-test)
  (add-hook 'compilation-finish-functions 'test-case-compilation-finish-run-all))


;;;; flymake
;;;(install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/emacs/emacs/lisp/progmodes/flymake.el")
(my-require-and-when 'flymake
  (global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

  ;; redefine to remove "check-syntax" target
  (defun flymake-get-make-cmdline (source base-dir)
    (list "make"
    (list "-s"
  	"-C"
  	base-dir
  	(concat "CHK_SOURCES=" source)
  	"SYNTAX_CHECK_MODE=1"))))


;;;; auto-compile
;;;; http://d.hatena.ne.jp/higepon/20061107/1162902929
;;;; http://sourceforge.net/project/showfiles.php?group_id=164970&package_id=210662
'(my-require-and-when 'auto-compile
  (setq auto-compile-target-path-regexp-list (list "\/src")))


;;;; ipa (in place annotations)
;;;(install-elisp-from-emacswiki "ipa.el")
(my-require-and-when 'ipa)


;;;; usage-memo
;;;(install-elisp-from-emacswiki "usage-memo.el")
'(my-require-and-when 'usage-memo
  (umemo-initialize))


;;;; develock (emphasize bad coding convention)
;;;; http://www.jpl.org/elips/develock.el.gz
(my-require-and-when 'develock
  (setq develock-auto-enable nil))


;;;; jaspace
;;;(install-elisp "http://homepage3.nifty.com/satomii/software/jaspace.el")
(my-require-and-when 'jaspace
  (setq jaspace-modes nil))


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


;;;; face-list
;;;; http://groups.google.com/group/gnu.emacs.sources/msg/06afad63bfa99322
;;;(my-require-and-when 'face-list)


(add-hook 'change-log-mode-hook
          (lambda ()
            (setq outline-regexp "\\(^[0-9A-Za-z]\\|[\t][*]\\)")
;;;            (outline-minor-mode t)
            (turn-on-orgstruct)))


;;;; color
;;; brace
(defface font-lock-brace-face
  '((((class color) (background light)) (:foreground "Red2"))
    (((class color) (background dark)) (:foreground "sienna1"))
    (t (:bold t :italic t)))
  "Font Lock mode face used for braces ()[]{} and the comma."
  :group 'font-lock-highlighting-faces)
(defvar font-lock-brace-face 'font-lock-brace-face
  "Face name to use for braces.")
(defconst bm-brace-keywords
  (cons
   "[][(){}]"
   font-lock-brace-face
   ))

(font-lock-add-keywords
 'c-mode
 (list
  bm-brace-keywords
  ))


;;;; macros
'(my-load-and-when "_paren-match"
  (define-key ctl-x-map "%" 'paren-match))
'(my-load-and-when "_tdd-bgcolor-rotate"
  (global-set-key "\C-cm" 'tdd-bgcolor-rotate))
(my-load-and-when "_google-code-search")
(my-load-and-when "_open-junk-file")


;; -*-no-byte-compile: t; -*-
