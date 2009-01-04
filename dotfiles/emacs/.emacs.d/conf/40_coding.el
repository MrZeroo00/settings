;; indent
(setq tab-width 2)
;(setq tab-stop-list
;      '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;(install-elisp "http://www.loveshack.ukfsn.org/emacs/indent-tabs-maybe.el")
(require 'indent-tabs-maybe)


;; paren
(show-paren-mode t)
;(setq show-paren-style 'mixed)
;(set-face-background 'show-paren-match-face "gray10")
;(set-face-foreground 'show-paren-match-face "SkyBlue")
;; mic-paren (highlight matching parenthesises)
;(install-elisp "http://user.it.uu.se/~mic/mic-paren.el")
(if window-system
    (progn
      (require 'mic-paren)
      (paren-activate)                  ; activating
      (setq paren-match-face 'bold)
      (setq paren-sexp-mode t)
      ))


;; generic (coloring generic files)
;(require 'generic-x)
;; association setting
;(add-to-list 'auto-mode-alist '("\\.bat$" . bat-generic-mode))
;(add-to-list 'auto-mode-alist '("\\.ini$" . ini-generic-mode))


;; ctags
(global-set-key "\M-t" 'find-tag)
(global-set-key "\C-t" 'pop-tag-mark)


;; gtags
;; http://tamacom.com/global-j.html
(autoload 'gtags-mode "gtags" "" t)

(setq gtags-mode-hook
      '(lambda ()
         (define-key gtags-mode-map "\M-t" 'gtags-find-tag-from-here)
         (define-key gtags-mode-map "\M-r" 'gtags-find-rtag)
         (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
         (define-key gtags-mode-map "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook '(lambda ()
                                 (gtags-mode 1)
                                 (gtags-make-complete-list)
                                 ))


;; xcscope
;; http://cscope.sourceforge.net/
;(require 'xcscope)


;; use ack
;(setq grep-command "ack -a --nocolor ")
;(defun ack ()
;  (interactive)
;  (let ((grep-find-command "ack --nocolor --nogroup "))
;    (call-interactively 'grep-find)))


;; speedbar
;(require 'speedbar)


;; template (insert template code)
(require 'autoinsert)
(setq auto-insert-directory "~/etc/emacs/template/")
(setq auto-insert-alist
      (nconc '( ("\\.c$" . "template.c")
                ("\\.f$" . "template.f")
                ) auto-insert-alist))

(add-hook 'find-file-not-found-hooks 'auto-insert)


;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/local/share/emacs/site-lisp/yasnippet/snippets")


;; brackets
;(install-elisp "http://www.mcl.chem.tohoku.ac.jp/~nakai/emacs/site-lisp/brackets.el")
(load "brackets")


;; align (align code)
;(require 'align)


;; eldoc
(autoload 'turn-on-eldoc-mode "eldoc" nil t)


;; doxymacs
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)

(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)


;; ediff
;(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 10000)


;; flymake
;(install-elisp "http://cvs.savannah.gnu.org/viewvc/*checkout*/emacs/emacs/lisp/progmodes/flymake.el")
(require 'flymake)

(global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))


;; auto-compile
;; http://d.hatena.ne.jp/higepon/20061107/1162902929
;; http://sourceforge.net/project/showfiles.php?group_id=164970&package_id=210662
(require 'auto-compile)
(setq auto-compile-target-path-regexp-list (list "\/src"))


;; gud
;(require 'gud)
(setq gud-gdb-command-name "gdb --annotate=3")


;; hs-minor-mode (fold code block)
(load-library "hideshow")

(setq hs-hide-comments nil)
(setq hs-isearch-open 't)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)


;; linum (show line number)
(require 'linum)
;(global-linum-mode t)
(setq linum-format "%5d ")


;; wrap-region
;(install-elisp "http://sami.samhuri.net/assets/2007/6/23/wrap-region.el")
(require 'wrap-region)


;; develock (emphasize bad coding convention)
;; http://www.jpl.org/elips/develock.el.gz
(load "develock")
(setq develock-auto-enable nil)


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


;; functions
(load "_paren-match")
(load "_tdd-bgcolor-rotate")
(global-set-key "\C-cm" 'tdd-bgcolor-rotate)
