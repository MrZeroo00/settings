(require 'cperl-mode)
;(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))


;; perl-completion
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/perl-completion/trunk/perl-completion.el")
(add-hook 'cperl-mode-hook
           (lambda ()
             (require 'perl-completion)
             (add-to-list 'ac-sources 'ac-source-perl-completion)))


;; brackets
(add-hook 'cperl-mode-hook
          '(lambda()
             (progn
               (define-key cperl-mode-map "{" 'insert-braces)
               (define-key cperl-mode-map "(" 'insert-parens)
               (define-key cperl-mode-map "\"" 'insert-double-quotation)
               (define-key cperl-mode-map "[" 'insert-brackets)
               (define-key cperl-mode-map "\C-c}" 'insert-braces-region)
               (define-key cperl-mode-map "\C-c)" 'insert-parens-region)
               (define-key cperl-mode-map "\C-c]" 'insert-brackets-region)
               (define-key cperl-mode-map "\C-c\"" 'insert-double-quotation-region)
               )))


;; add use statement
(add-hook 'cperl-mode-hook
          (lambda ()
            (local-set-key (kbd "\C-c \C-m") 'perl-insert-use-statement)))

(defun perl-insert-use-statement (current-point)
  "use statement auto-insertion."
  (interactive "d")
  (insert-use-statement
   (detect-module-name current-point)
   (detect-insert-point)))

(defun insert-use-statement (module-name insert-point)
  (save-excursion
    (goto-char insert-point)
    (insert (concat "\nuse " module-name ";\n"))))

(defun detect-insert-point ()
  (save-excursion
    (if (re-search-backward "use .+;" 1 t)
        (match-end 0)
      (progn
        (string-match "^$" (buffer-string))
        (match-end 0)))))

(defun detect-module-name (current-point)
  (let ((str (save-excursion
               (buffer-substring
                current-point
                (progn (beginning-of-line) (point))))))
    (if (string-match "\\([[:alnum:]-_:]+\\)$" str)
        (match-string 1 str)
      (error "Module name not found"))))


;; perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))
