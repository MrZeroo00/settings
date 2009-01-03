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


;; gtags
;; http://tamacom.com/global-j.html
(autoload 'gtags-mode "gtags" "" t)

(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook '(lambda ()
                                 (gtags-mode 1)
                                 (gtags-make-complete-list)
                                 ))


;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 10000)


;; use ack
;(setq grep-command "ack -a --nocolor ")
;(defun ack ()
;  (interactive)
;  (let ((grep-find-command "ack --nocolor --nogroup "))
;    (call-interactively 'grep-find)))


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


;; hs-minor-mode (fold code block)
(load-library "hideshow")

(setq hs-hide-comments nil)
(setq hs-isearch-open 't)

(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)


;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/local/share/emacs/site-lisp/yasnippet/snippets")


;; brackets
;(install-elisp "http://www.mcl.chem.tohoku.ac.jp/~nakai/emacs/site-lisp/brackets.el")
(load "brackets")


;; linum (show line number)
(require 'linum)
;(global-linum-mode t)
(setq linum-format "%5d ")


;; wrap-region
;(install-elisp "http://sami.samhuri.net/assets/2007/6/23/wrap-region.el")
(require 'wrap-region)


;; align (align code)
(require 'align)


;; template (insert template code)
(require 'autoinsert)
(setq auto-insert-directory "~/etc/emacs/template/")
(setq auto-insert-alist
      (nconc '( ("\\.c$" . "template.c")
                ("\\.f$" . "template.f")
                ) auto-insert-alist))

(add-hook 'find-file-not-found-hooks 'auto-insert)


;; develock (emphasize bad coding convention)
;; http://www.jpl.org/elips/develock.el.gz
(load "develock")
(setq develock-auto-enable nil)


;; p4
;; http://p4el.sourceforge.net/
;(load-library "p4")


;; paren-match
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=kakko%20warp
(progn
  (defvar com-point nil
    "Remember com point as a marker. \(buffer specific\)")
  (set-default 'com-point (make-marker))
  (defun getcom (arg)
    "Get com part of prefix-argument ARG."
    (cond ((null arg) nil)
          ((consp arg) (cdr arg))
          (t nil)))
  (defun paren-match (arg)
    "Go to the matching parenthesis."
    (interactive "P")
    (let ((com (getcom arg)))
      (if (numberp arg)
          (if (or (> arg 99) (< arg 1))
              (error "Prefix must be between 1 and 99.")
            (goto-char
             (if (> (point-max) 80000)
                 (* (/ (point-max) 100) arg)
               (/ (* (point-max) arg) 100)))
            (back-to-indentation))
        (cond ((looking-at "[\(\[{]")
               (if com (move-marker com-point (point)))
               (forward-sexp 1)
               (if com
                   (paren-match nil com)
                 (backward-char)))
              ((looking-at "[])]}")
               (forward-char)
               (if com (move-marker com-point (point)))
               (backward-sexp 1)
               (if com (paren-match nil com)))
              (t (error ""))))))
  (define-key ctl-x-map "%" 'paren-match))


;; emphasize Space/Tab/Newline
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


;; generic (coloring generic files)
;(require 'generic-x)
;(setq auto-mode-alist (append (list
;                               '("\\.bat$" . bat-generic-mode)
;                               '("\\.ini$" . ini-generic-mode)
;                               auto-mode-alist)))


;; assist TDD
;; http://d.hatena.ne.jp/xcezx/20080305/1204698047
;; http://coderepos.org/share/browser/dotfiles/emacs/typester/.emacs.d/conf/60_tdd.el
(defvar tdd-bgcolor-alist
  '(("Think"       . "while")
    ("Red"         . "#ff4444")
    ("Green"       . "#44dd44")
    ("Refactoring" . "#ffaa44")))

(defvar tdd-bgcolor-mode 3)
(defvar tdd-bgcolor-mode-name "")
(let (
      (cell (or (memq 'mode-line-position mode-line-format)
                (memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr 'tdd-bgcolor-mode-name))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun tdd-bgcolor-rotate ()
  (interactive)
  (let (pair)
    (if (>= tdd-bgcolor-mode 3)
        (setq tdd-bgcolor-mode 0)
      (setq tdd-bgcolor-mode
            (+ tdd-bgcolor-mode 1)))
    (setq pair
          (nth tdd-bgcolor-mode tdd-bgcolor-alist))
    (setq tdd-bgcolor-mode-name (format "[%s]" (car pair)))
    (message tdd-bgcolor-mode-name)
    (set-face-foreground 'mode-line (cdr pair))
    (set-face-bold-p 'mode-line t)
    ))

(global-set-key "\C-cm" 'tdd-bgcolor-rotate)
