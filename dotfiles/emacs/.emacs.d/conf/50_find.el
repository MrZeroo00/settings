; for coding
(setq grep-find-command "find . -type f ! -name '*,v' ! -name '*~' ! -name '*.o' ! -name '*.a' ! -name '*.so' ! -name '*.class' ! -name '*.jar' ! -name 'semantic.cache' ! -path '*.deps*' ! -path '*/obsolete/*' ! -path '*/.svn/*' ! -path '*/CVS/*' -print0 | xargs -0 -e grep -n -e ")


;; color-grep
;(install-elisp "http://www.bookshelf.jp/elc/color-grep.el")
(require 'color-grep)
(setq color-grep-sync-kill-buffer t)


;; grep-edit
(require 'grep)
;(install-elisp "http://www.bookshelf.jp/elc/grep-edit.el")
(require 'grep-edit)

;; http://d.hatena.ne.jp/rubikitch/20081025/1224869598
(defadvice grep-edit-change-file (around inhibit-read-only activate)
  ""
  (let ((inhibit-read-only t))
    ad-do-it))
;; (progn (ad-disable-advice 'grep-edit-change-file 'around 'inhibit-read-only) (ad-update 'grep-edit-change-file))

(defun my-grep-edit-setup ()
  (define-key grep-mode-map '[up] nil)
  (define-key grep-mode-map "\C-c\C-c" 'grep-edit-finish-edit)
  (message (substitute-command-keys "\\[grep-edit-finish-edit] to apply changes."))
  (set (make-local-variable 'inhibit-read-only) t)
  )
(add-hook 'grep-setup-hook 'my-grep-edit-setup t)


;; isearch-all
;(install-elisp "http://www.bookshelf.jp/elc/isearch-all.el")
;(load "isearch-all")


;; qsearch
;(install-elisp-from-emacswiki "qsearch.el")
;(require 'qsearch)


;; ireplace
;(install-elisp "http://www.bookshelf.jp/elc/ireplace.el")
;(require 'ireplace)


;; namazu
;(install-elisp "http://www.bookshelf.jp/elc/namazu.el")
;(setq namazu-search-num 100)
;(setq namazu-auto-turn-page t)
;(autoload 'namazu "namazu" nil t)
;(setq namazu-default-dir "~/etc/namazu/")
;(setq namazu-dir-alist
;      '(("doc" . "~/etc/namazu/index")
;        ))
;(install-elisp "http://www.bookshelf.jp/elc/color-namazu.el")
;(load "color-namazu")


;; http://dev.ariel-networks.com/Members/matsuyama/isearch-selected-text
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active)
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))


;; isearch-exit
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=isearch-exit
;(define-key isearch-mode-map "\M-m" 'isearch-exit)
;(add-hook 'isearch-mode-end-hook
;          (lambda ()
;            (cond
;             ((eq last-input-char ?\C-m)
;              (goto-char (match-end 0)))
;             ((eq last-input-char ?\M-m)
;              (goto-char (match-beginning 0))))))


;; macros
(load "_isearch-yank-char")
;(define-key isearch-mode-map "\C-d" 'isearch-yank-char)
(load "_isearch-real-delete-char")
;(define-key isearch-mode-map "\C-o" 'isearch-real-delete-char)
