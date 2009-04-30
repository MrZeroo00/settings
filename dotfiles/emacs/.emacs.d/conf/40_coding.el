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


;; gdb
(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer t)


;; generic (coloring generic files)
;(require 'generic-x)
;; association setting
;(add-to-list 'auto-mode-alist '("\\.bat$" . bat-generic-mode))
;(add-to-list 'auto-mode-alist '("\\.ini$" . ini-generic-mode))


;; cedet
;; http://cedet.sourceforge.net/
;(load "~/local/share/emacs/site-lisp/cedet/common/cedet.el")
;(global-ede-mode 1)
;;(ede-cpp-root-project "NAME" :file "~/myproject/Makefile")
;(semantic-load-enable-minimum-features)
;(semantic-load-enable-code-helpers)
;;(semantic-load-enable-gaudy-code-helpers)
;;(semantic-load-enable-all-exuberent-ctags-support)
;;(global-srecode-minor-mode 1)


;; ecb
;; http://ecb.sourceforge.net/
;(require 'ecb-autoloads)


;; textmate
;(install-elisp "http://github.com/defunkt/textmate.el/raw/master/textmate.el")
;(require 'textmate)
;(textmate-mode)


;; ctags
(global-set-key "\M-t" 'find-tag)
(global-set-key "\C-t" 'pop-tag-mark)
(setq tags-table-list
      '("~/src"))


;; gtags
;; http://tamacom.com/global-j.html
(autoload 'gtags-mode "gtags" "" t)

(defun my-find-tag ()
  (interactive)
  (or (gtags-find-tag-from-here)
      (find-tag)))

(setq gtags-mode-hook
      '(lambda ()
         (load "_gtags-hack.el")
         (define-key gtags-mode-map "\M-t" 'gtags-find-tag-from-here)
         (define-key gtags-mode-map "\M-r" 'gtags-find-rtag)
         (define-key gtags-mode-map "\M-s" 'gtags-find-symbol)
         (define-key gtags-mode-map "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook '(lambda ()
                                 (gtags-mode t)
                                 ))


;; imenu
;(require 'imenu)


;; xcscope
;; http://cscope.sourceforge.net/
;(require 'xcscope)


;; use ack
(setq grep-command "ack -a --nocolor ")
(defun ack ()
  (interactive)
  (let ((grep-find-command "ack --nocolor --nogroup "))
    (call-interactively 'grep-find)))


;; speedbar
;(require 'speedbar)


;; which-func
(require 'which-func)
(which-func-mode t)


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


;; eldoc-extension
;(install-elisp-from-emacswiki "eldoc-extension.el")
(require 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)


;; mode-info
;; http://www.namazu.org/~tsuchiya/elisp/mode-info.html
;(require 'mi-config)
;;(define-key global-map "\C-hf" 'mode-info-describe-function)
;;(define-key global-map "\C-hv" 'mode-info-describe-variable)
;;(define-key global-map "\M-." 'mode-info-find-tag)
;(require 'mi-fontify)
;(setq mode-info-index-directory "~/.emacs.d")
;(setq mode-info-class-alist
;      '((elisp  emacs-lisp-mode lisp-interaction-mode)
;        (libc   c-mode c++-mode)
;        (make   makefile-mode)
;        (perl   perl-mode cperl-mode eperl-mode)
;        (ruby   ruby-mode)
;        (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode)))


;; info-look
(require 'info-look)


;; gtk-look
;(install-elisp "http://www.geocities.com/user42_kevin/gtk-look/gtk-look.el.txt")
(autoload 'gtk-lookup-symbol "gtk-look" nil t)
(when run-linux
  (setq gtk-lookup-devhelp-indices
        '("/usr/share/doc/lib*-doc/*.devhelp*"
          "/usr/share/doc/lib*-doc/*/*.devhelp*"
          "/usr/share/doc/lib*-doc/*/*/*.devhelp*")))
(when run-darwin
  (setq gtk-lookup-devhelp-indices
        '("/opt/local/share/gtk-doc/html/*/*.devhelp")))


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

; redefine to remove "check-syntax" target
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s"
              "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))


;; auto-compile
;; http://d.hatena.ne.jp/higepon/20061107/1162902929
;; http://sourceforge.net/project/showfiles.php?group_id=164970&package_id=210662
;(require 'auto-compile)
;(setq auto-compile-target-path-regexp-list (list "\/src"))


;; gud
;(require 'gud)
(setq gud-gdb-command-name "gdb --annotate=3")


;; ipa (in place annotations)
;(install-elisp-from-emacswiki "ipa.el")
(require 'ipa)


;; usage-memo
;(install-elisp-from-emacswiki "usage-memo.el")
(require 'usage-memo)
(umemo-initialize)


;; hs-minor-mode (fold code block)
(load "hideshow")

(setq hs-hide-comments nil)
(setq hs-isearch-open 't)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

(load "_hs-hide-all-comments")


;; linum (show line number)
(require 'linum)
;(global-linum-mode t)
(setq linum-format "%5d ")


;; wrap-region
;(install-elisp "http://sami.samhuri.net/assets/2007/6/23/wrap-region.el")
(require 'wrap-region)


;; flyspell
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)


;; develock (emphasize bad coding convention)
;; http://www.jpl.org/elips/develock.el.gz
(load "develock")
(setq develock-auto-enable nil)


;; jaspace
;(install-elisp "http://homepage3.nifty.com/satomii/software/jaspace.el")
(require 'jaspace)
(setq jaspace-modes nil)


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


(add-hook 'change-log-mode-hook
          (lambda ()
            (setq outline-regexp "\\(^[0-9A-Za-z]\\|[\t][*]\\)")
            ;(outline-minor-mode t)
            (turn-on-orgstruct)))


;; pov-mode
;; http://www.acc.umu.se/~woormie/povray/
;(autoload 'pov-mode "pov-mode.el" "PoVray scene file mode" t)
;(setq auto-mode-alist
;      (append '(("\\.pov$" . pov-mode)
;                ("\\.inc$" . pov-mode)
;                ) auto-mode-alist))


;; macros
(load "_paren-match")
(load "_tdd-bgcolor-rotate")
(global-set-key "\C-cm" 'tdd-bgcolor-rotate)
(load "_google-code-search")
(load "_open-junk-file")
