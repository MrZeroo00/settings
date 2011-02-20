;;;; for coding
(setq grep-find-command "find . -type f ! -name '*,v' ! -name '*~' ! -name '*.o' ! -name '*.a' ! -name '*.so' ! -name '*.class' ! -name '*.jar' ! -name 'semantic.cache' ! -path '*.deps*' ! -path '*/obsolete/*' ! -path '*/.svn/*' ! -path '*/CVS/*' -print0 | xargs -0 -e grep -n -e ")


;;;; grep-a-lot
;;;(install-elisp-from-emacswiki "grep-a-lot")
(my-require-and-when 'grep-a-lot
  (defvar my-grep-a-lot-search-word nil)
  ;; overwrite defined function
  (defun grep-a-lot-buffer-name (position)
    "Return name of grep-a-lot buffer at POSITION."
    (concat "*grep*<" my-grep-a-lot-search-word ">"))

  (defadvice rgrep (before my-rgrep (regexp &optional files dir) activate)
    (setq my-grep-a-lot-search-word regexp))

  (defadvice lgrep (before my-lgrep (regexp &optional files dir) activate)
    (setq my-grep-a-lot-search-word regexp))
  )


;;;; color-grep
;;;(install-elisp "http://www.bookshelf.jp/elc/color-grep.el")
(my-require-and-when 'color-grep
  (setq color-grep-sync-kill-buffer t))


;;;; grep-edit
(my-require-and-when 'grep)
;;;(install-elisp "http://www.bookshelf.jp/elc/grep-edit.el")
(my-require-and-when 'grep-edit
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
  (add-hook 'grep-setup-hook 'my-grep-edit-setup t))


;;;; ireplace
;;;(install-elisp "http://www.bookshelf.jp/elc/ireplace.el")
;;;(my-require-and-when 'ireplace)


;;;; approx-search
;;;; http://www.geocities.co.jp/SiliconValley-PaloAlto/7043/
'(my-require-and-when 'approx-search
  (if (boundp 'isearch-search-fun-function)
      (my-require-and-when 'approx-isearch)
    (my-require-and-when 'approx-old-isearch))

  (if migemo-isearch-enable-p
      (approx-isearch-set-disable)
    (approx-isearch-set-enable))

  (defadvice migemo-toggle-isearch-enable (before approx-ad-migemo-toggle-i
                                                  arch-enable activate)
    "migemo を使う時は approx-search を使わない."
    (if migemo-isearch-enable-p
        (approx-isearch-set-enable) ; NOT disable!!! before advice なので
      (approx-isearch-set-disable))))


;;;; namazu
;;;(install-elisp "http://www.bookshelf.jp/elc/namazu.el")
'(my-autoload-and-when 'namazu "namazu"
                      (setq namazu-search-num 100)
                      (setq namazu-auto-turn-page t)
                      (setq namazu-default-dir "~/etc/namazu/")
                      (setq namazu-dir-alist
                            '(("doc" . "~/etc/namazu/index")
                              )))
;;;(install-elisp "http://www.bookshelf.jp/elc/color-namazu.el")
;;;(my-require-and-when 'color-namazu)


;;;; http://dev.ariel-networks.com/Members/matsuyama/isearch-selected-text
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


;;;; macros
'(my-load-and-when "_isearch-yank-char"
  (define-key isearch-mode-map "\C-d" 'isearch-yank-char))
'(my-load-and-when "_isearch-real-delete-char"
  (define-key isearch-mode-map "\C-o" 'isearch-real-delete-char))
;;;(my-load-and-when "_isearch-forward-comment-only")
'(my-load-and-when "_my-igrep")


;; -*-no-byte-compile: t; -*-
