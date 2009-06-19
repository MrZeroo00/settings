(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;(setq dired-listing-switches "-AFl")
(setq dired-listing-switches "-Alph")
(setq find-ls-option '("-exec ls -AFGl {} \\;" . "-AFGl"))
(setq grep-find-command "find . -type f -print0 | xargs -0 -e grep -ns ")


;; ls-lisp
(require 'ls-lisp)
(setq ls-lisp-dirs-first t)


;; find-dired-lisp (filter file list)
;(install-elisp "http://www.bookshelf.jp/elc/find-dired-lisp.el")
(autoload 'find-dired-lisp
  "find-dired-lisp" "findr" t nil)
(autoload 'find-grep-dired-lisp
  "find-dired-lisp" "findr" t nil)


;; sorter (sort file list)
;(install-elisp "http://www.bookshelf.jp/elc/sorter.el")
(add-hook 'dired-load-hook
          (lambda ()
            (require 'sorter)))


;; dired-x
(load "dired-x")

;(setq dired-guess-shell-alist-user
;      '(("\\.tar\\.gz\\'" "tar ztvf")
;        ("\\.taz\\'" "tar ztvf")
;        ("\\.tar\\.bz2\\'" "tar Itvf")
;        ("\\.zip\\'" "unzip -l")
;        ("\\.\\(g\\|\\) z\\'" "zcat")
;        ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'"
;         (if (eq system-type 'windows-nt)
;             "fiber" "xv"))
;        ("\\.ps\\'"
;         (if (eq system-type 'windows-nt)
;             "fiber" "ghostview"))
;        ))
;)))


;; my-dired-mode
;(install-elisp "http://www.bookshelf.jp/elc/my-dired-mode.el")
;(load "my-dired-mode")


;; wdired (rename file name from dired buffer)
;(install-elisp-from-emacswiki "wdired.el")
(require 'wdired)
;(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; bf-mode (show file content)
;(install-elisp "http://www.bookshelf.jp/elc/bf-mode.el")
(require 'bf-mode)
(setq bf-mode-browsing-size 10)
;(setq bf-mode-except-ext '("\\.exe$" "\\.com$"))
;(setq bf-mode-force-browse-exts
;      (append '("\\.texi$" "\\.el$")
;              bf-mode-force-browse-exts))
(setq bf-mode-html-with-w3m t)
(setq bf-mode-archive-list-verbose t)
(setq bf-mode-directory-list-verbose t)


;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=dired%20single
;(defvar my-dired-before-buffer nil)
;(defadvice dired-advertised-find-file
;  (before kill-dired-buffer activate)
;  (setq my-dired-before-buffer (current-buffer)))
;
;(defadvice dired-advertised-find-file
;  (after kill-dired-buffer-after activate)
;  (if (eq major-mode 'dired-mode)
;      (kill-buffer my-dired-before-buffer)))
;
;(defadvice dired-up-directory
;  (before kill-up-dired-buffer activate)
;  (setq my-dired-before-buffer (current-buffer)))
;
;(defadvice dired-up-directory
;  (after kill-up-dired-buffer-after activate)
;  (if (eq major-mode 'dired-mode)
;      (kill-buffer my-dired-before-buffer)))


;; http://d.hatena.ne.jp/higepon/20061230/1167447340
;(defadvice dired-sort-other
;  (around dired-sort-other-h activate)
;  (ad-set-arg 0 (concat (ad-get-arg 0) "h"))
;  ad-do-it
;  (setq dired-actual-switches (dired-replace-in-string "h" "" dired-actual-switches)))


;; macros
(load "_dired-toggle-mark")
(define-key dired-mode-map " " 'dired-toggle-mark)
(load "_dired-convert-coding-system")
(load "_dired-ps-print-files")
;(load "_ls-lisp-handle-switches")
;(load "_dired-face-file-edited-today")
(when (and run-w32 run-meadow)
  '(progn
     ;; w32-symlinks
     ;(install-elisp "http://centaur.maths.qmw.ac.uk/Emacs/files/w32-symlinks.el")
     (require 'w32-symlinks)
     (load "_dired-make-symbolic-link")
     ;(add-hook 'dired-mode-hook
     ;          '(lambda ()
     ;             (define-key dired-mode-map "S" (function dired-make-symbolic-link))
     ;             ))
     (load "_dired-winstart")
     ;(add-hook 'dired-mode-hook
     ;          (lambda ()
     ;            (define-key dired-mode-map "z" 'uenox-dired-winstart)))
     ))
