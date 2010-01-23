;(install-elisp-from-emacswiki "one-key.el")
(require 'one-key nil t)
(require 'one-key-config nil t)
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 50000)


;; Gtags menu
(defvar one-key-menu-gtags-alist nil
  "`One-Key' menu list for Gtags.")

(setq one-key-menu-gtags-alist
      '(
        (("b" . "Display browser") . gtags-display-browser)
        (("h" . "Find tag from here") . gtags-find-tag-from-here)
        (("p" . "Pop stack") . gtags-pop-stack)
        (("f" . "Find file") . gtags-find-file)
        (("g" . "Find with grep") . gtags-find-with-grep)
        (("i" . "Find with idutils") . gtags-find-with-idutils)
        (("s" . "Find symbol") . gtags-find-symbol)
        (("r" . "Find rtag") . gtags-find-rtag)
        (("t" . "Find tag") . gtags-find-tag)
        (("v" . "Visit rootdir") . gtags-visit-rootdir)))

(defun one-key-menu-gtags ()
   "`One-Key' menu for Gtags."
   (interactive)
   (one-key-menu "Gtags" one-key-menu-gtags-alist t))


;; Root menu
(setq one-key-menu-root-alist
      '(
        (("g" . "Gtags") . one-key-menu-gtags)))

(defun one-key-menu-root ()
  (interactive)
  (one-key-menu "ROOT" one-key-menu-root-alist nil))

(global-set-key (kbd "C-c p") 'one-key-menu-root)


;; one-key-default
;(install-elisp-from-emacswiki "one-key-default.el")
;(require 'one-key-default nil t)
;(one-key-default-setup-keys)
