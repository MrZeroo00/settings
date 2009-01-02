;; indent
(setq tab-width 2)
;(setq tab-stop-list
;      '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30))
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
(require 'indent-tabs-maybe)


;; paren
(show-paren-mode t)
;(setq show-paren-style 'mixed)
;(set-face-background 'show-paren-match-face "gray10")
;(set-face-foreground 'show-paren-match-face "SkyBlue")
;; mic-paren (highlight matching parenthesises)
(if window-system
    (progn
      (require 'mic-paren)
      (paren-activate)                  ; activating
      (setq paren-match-face 'bold)
      (setq paren-sexp-mode t)
      ))


;; gtags
(autoload 'gtags-mode "gtags" "" t)

(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
(add-hook 'c-mode-common-hook
          '(lambda ()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))


;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 10000)


;; flymake
(require 'flymake)

(global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))


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
(load "develock")
(setq develock-auto-enable nil)


;; generic (coloring generic files)
;(require 'generic-x)
;(setq auto-mode-alist (append (list
;                               '("\\.bat$" . bat-generic-mode)
;                               '("\\.ini$" . ini-generic-mode)
;                               auto-mode-alist)))