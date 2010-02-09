;; indent
(setq tab-width 2)
;(setq tab-stop-list
;      '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;(install-elisp "http://www.loveshack.ukfsn.org/emacs/indent-tabs-maybe.el")
(my-require-and-when 'indent-tabs-maybe)
;; http://d.hatena.ne.jp/mzp/20090620/indent
'(my-require-and-when 'ky-indent
  (ky-indent-init)
  (setq ky-indent-regexp "external-code/")
  )


;; paren
(show-paren-mode t)
;(setq show-paren-style 'mixed)
;(set-face-background 'show-paren-match-face "gray10")
;(set-face-foreground 'show-paren-match-face "SkyBlue")
;; mic-paren (highlight matching parenthesises)
;(install-elisp "http://user.it.uu.se/~mic/mic-paren.el")
(if window-system
    (progn
      (my-require-and-when 'mic-paren
	(paren-activate)                  ; activating
	(setq paren-match-face 'bold)
	(setq paren-sexp-mode t))
      ))


;; comment
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(setq comment-style 'multi-line)


;; ifdef
'(setq hide-ifdef-define-alist
      '((list-name
	 DEFINE1
	 DEFINE2
	 ))


;; debug
(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer t)
(my-require-and-when 'gud
  (setq gud-gdb-command-name "gdb -annotate=3")
  (setq gud-tooltip-echo-area nil)
  (add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t))))


;; generic (coloring generic files)
'(my-require-and-when 'generic-x
  ;; association setting
  (add-to-list 'auto-mode-alist '("\\.bat$" . bat-generic-mode))
  (add-to-list 'auto-mode-alist '("\\.ini$" . ini-generic-mode)))


;; cedet
;; http://cedet.sourceforge.net/
'(my-load-and-when "~/local/share/emacs/site-lisp/cedet/common/cedet.el"
  (global-ede-mode 1)
  ;;(ede-cpp-root-project "NAME" :file "~/myproject/Makefile")
  (semantic-load-enable-minimum-features)
  (semantic-load-enable-code-helpers)
  ;;(semantic-load-enable-gaudy-code-helpers)
  ;;(semantic-load-enable-all-exuberent-ctags-support)
  ;;(global-srecode-minor-mode 1)
  )


;; ecb
;; http://ecb.sourceforge.net/
;(my-require-and-when 'ecb-autoloads)


;; textmate
;(install-elisp "http://github.com/defunkt/textmate.el/raw/master/textmate.el")
'(my-require-and-when 'textmate
  (textmate-mode))


;; ctags
;(global-set-key "\M-t" 'find-tag)
;(global-set-key "\C-t" 'pop-tag-mark)
;(setq tags-table-list
;      '("~/src"))


;; gtags
;; http://tamacom.com/global-j.html
(my-autoload-and-when 'gtags-mode "gtags"
		      (defun my-find-tag ()
			(interactive)
			(or (gtags-find-tag-from-here)
			    (find-tag)))

		      (setq gtags-mode-hook
			    '(lambda ()
			       (my-load-and-when "_gtags-hack.el")
			       (define-key gtags-mode-map "\M-t" 'gtags-find-tag-from-here)
			       (define-key gtags-mode-map "\M-r" 'gtags-find-rtag)
			       (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
			       (define-key gtags-mode-map "\C-t" 'gtags-pop-stack)
			       )))

(add-hook 'c-mode-common-hook '(lambda ()
				 (gtags-mode t)
				 ;;(gtags-make-complete-list)
				 ))


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=tagsfile%20maker
'(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))


;; imenu
(my-require-and-when 'imenu)


;; xcscope
;; http://cscope.sourceforge.net/
;(my-require-and-when 'xcscope)


;; use ack
(setq grep-command "ack -a --nocolor ")
(defun ack ()
  (interactive)
  (let ((grep-find-command "ack --nocolor --nogroup "))
    (call-interactively 'grep-find)))


;; speedbar
;(my-require-and-when 'speedbar)


;; which-func
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


;; template (insert template code)
'(my-require-and-when 'autoinsert
  (setq auto-insert-directory "~/etc/emacs/template/")
  (setq auto-insert-alist
	(nconc '( ("\\.c$" . "template.c")
		  ("\\.f$" . "template.f")
		  ) auto-insert-alist))

  (add-hook 'find-file-not-found-hooks 'auto-insert))


;; yasnippet
'(my-require-and-when 'yasnippet
  (yas/initialize)
  (yas/load-directory "~/local/share/emacs/site-lisp/yasnippet/snippets"))


;; brackets
;(install-elisp "http://www.mcl.chem.tohoku.ac.jp/~nakai/emacs/site-lisp/brackets.el")
;(my-load-and-when "brackets")


;; align (align code)
(my-require-and-when 'align)


;; eldoc
(my-autoload-and-when 'turn-on-eldoc-mode "eldoc")


;; eldoc-extension
;(install-elisp-from-emacswiki "eldoc-extension.el")
(my-require-and-when 'eldoc-extension
  (setq eldoc-idle-delay 0)
  (setq eldoc-echo-area-use-multiline-p t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))


;; mode-info
;; http://www.namazu.org/~tsuchiya/elisp/mode-info.html
'(my-require-and-when 'mi-config
  ;;(define-key global-map "\C-hf" 'mode-info-describe-function)
  ;;(define-key global-map "\C-hv" 'mode-info-describe-variable)
  ;;(define-key global-map "\M-." 'mode-info-find-tag)
  (my-require-and-when 'mi-fontify)
  (setq mode-info-index-directory "~/.emacs.d")
  (setq mode-info-class-alist
	'((elisp  emacs-lisp-mode lisp-interaction-mode)
	  (libc   c-mode c++-mode)
	  (make   makefile-mode)
	  (perl   perl-mode cperl-mode eperl-mode)
	  (ruby   ruby-mode)
	  (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode))))


;; info-look
(my-require-and-when 'info-look)


;; gtk-look
;(install-elisp "http://www.geocities.com/user42_kevin/gtk-look/gtk-look.el.txt")
(my-autoload-and-when 'gtk-lookup-symbol "gtk-look"
		      (when run-linux
			(setq gtk-lookup-devhelp-indices
			      '("/usr/share/doc/lib*-doc/*.devhelp*"
				"/usr/share/doc/lib*-doc/*/*.devhelp*"
				"/usr/share/doc/lib*-doc/*/*/*.devhelp*")))
		      (when run-darwin
			(setq gtk-lookup-devhelp-indices
			      '("/opt/local/share/gtk-doc/html/*/*.devhelp"))))


;; doxymacs
(my-require-and-when 'doxymacs
  (add-hook 'c-mode-common-hook 'doxymacs-mode)

  (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
	(doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook))


;; ediff
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


;; flymake
;(install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/emacs/emacs/lisp/progmodes/flymake.el")
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


;; auto-compile
;; http://d.hatena.ne.jp/higepon/20061107/1162902929
;; http://sourceforge.net/project/showfiles.php?group_id=164970&package_id=210662
'(my-require-and-when 'auto-compile
  (setq auto-compile-target-path-regexp-list (list "\/src")))


;; ipa (in place annotations)
;(install-elisp-from-emacswiki "ipa.el")
(my-require-and-when 'ipa)


;; usage-memo
;(install-elisp-from-emacswiki "usage-memo.el")
'(my-require-and-when 'usage-memo
  (umemo-initialize))


;; hs-minor-mode (fold code block)
(my-load-and-when "hideshow"
  (setq hs-hide-comments nil)
  (setq hs-isearch-open 't)

  (add-hook 'c-mode-hook 'hs-minor-mode)
  (add-hook 'perl-mode-hook 'hs-minor-mode)
  (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

  (my-load-and-when "_hs-hide-all-comments"))


;; linum (show line number)
(my-require-and-when 'linum
  ;;(global-linum-mode t)
  (setq linum-format "%5d "))


;; wrap-region
;(install-elisp "http://sami.samhuri.net/assets/2007/6/23/wrap-region.el")
(my-require-and-when 'wrap-region)


;; flyspell
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)


;; develock (emphasize bad coding convention)
;; http://www.jpl.org/elips/develock.el.gz
(my-load-and-when "develock"
  (setq develock-auto-enable nil))


;; jaspace
;(install-elisp "http://homepage3.nifty.com/satomii/software/jaspace.el")
(my-require-and-when 'jaspace
  (setq jaspace-modes nil))


;; emphasize Space/Tab/Newline
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=visualize%20tab
;;;(defface my-face-r-1 '((t (:background "gray15"))) nil)
;(defface my-face-b-1 '((t (:background "gray"))) nil)
;(defface my-face-b-2 '((t (:background "gray26"))) nil)
;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;;;(defvar my-face-r-1 'my-face-r-1)
;(defvar my-face-b-1 'my-face-b-1)
;(defvar my-face-b-2 'my-face-b-2)
;(defvar my-face-u-1 'my-face-u-1)
;
;(defadvice font-lock-mode (before my-font-lock-mode ())
;  (font-lock-add-keywords
;   major-mode
;   '(("\t" 0 my-face-b-2 append)
;     ("¡¡" 0 my-face-b-1 append)
;     ("[ \t]+$" 0 my-face-u-1 append)
;     ;;("[\r]*\n" 0 my-face-r-1 append)
;     )))
;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;(ad-activate 'font-lock-mode)


;; face-list
;; http://groups.google.com/group/gnu.emacs.sources/msg/06afad63bfa99322
;(my-require-and-when 'face-list)


(add-hook 'change-log-mode-hook
          (lambda ()
            (setq outline-regexp "\\(^[0-9A-Za-z]\\|[\t][*]\\)")
            ;(outline-minor-mode t)
            (turn-on-orgstruct)))


;; pov-mode
;; http://www.acc.umu.se/~woormie/povray/
;(my-autoload-and-when 'pov-mode "pov-mode.el")
'(setq auto-mode-alist
      (append '(("\\.pov$" . pov-mode)
		("\\.inc$" . pov-mode)
		) auto-mode-alist))


;; to pop up compilation buffers at the bottom
(my-eval-after-load "split-root"
  (require 'compile)
  (defvar compilation-window nil
    "The window opened for displaying a compilation buffer.")

  (setq compilation-window-height 14)

  (defun my-display-buffer (buffer &optional not-this-window)
    (if (or (compilation-buffer-p buffer)
	    (equal (buffer-name buffer) "*Shell Command Output*"))
	(progn
	  (unless (and my-compilation-window (window-live-p my-compilation-window))
	    (setq my-compilation-window (split-root-window compilation-window-height))
	    (set-window-buffer my-compilation-window buffer))
	  my-compilation-window)
      (let ((display-buffer-function nil))
	(display-buffer buffer not-this-window))))

  (setq display-buffer-function 'my-display-buffer)

  ;; on success, delete compilation window right away!
  (add-hook 'compilation-finish-functions
	    '(lambda(buf res)
	       (unless (or (eq last-command 'grep)
			   (eq last-command 'grep-find))
		 (when (equal res "finished\n")
		   (when compilation-window
		     (delete-window compilation-window)
		     (setq compilation-window nil))
		   (message "compilation successful")))))
  )


;; macros
(my-load-and-when "_paren-match")
'(my-load-and-when "_tdd-bgcolor-rotate"
  (global-set-key "\C-cm" 'tdd-bgcolor-rotate))
(my-load-and-when "_google-code-search")
(my-load-and-when "_open-junk-file")
