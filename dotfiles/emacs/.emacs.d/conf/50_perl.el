(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))


;; perl-completion
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/perl-completion/trunk/perl-completion.el")
(add-hook 'cperl-mode-hook
           (lambda ()
             (require 'perl-completion)
             (add-to-list 'ac-sources 'ac-source-perl-completion)))
