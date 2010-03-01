(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(setq ruby-deep-indent-paren-style nil)


;;;; flymake
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
   (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '(".+\\.rb$" flymake-ruby-init))

(my-add-hook 'ruby-mode-hook
          (lambda ()
            (inf-ruby-keys)
            (flymake-mode t)))


;;;; refe
;;;(install-elisp "http://ns103.net/~arai/ruby/refe.el")
;;;(my-require-and-when 'refe)
;;;; http://d.hatena.ne.jp/rubikitch/20071228/rubyrefm
;;;(install-elisp "http://www.rubyist.net/~rubikitch/archive/refe2.e")
(my-add-hook 'ruby-mode-hook
          (lambda ()
            (my-load-and-when "_refe2")))


;;;; autotest
;;;(install-elisp-from-emacswiki "autotest.el")
(my-add-hook 'ruby-mode-hook
          (lambda ()
            (my-require-and-when 'autotest)))


;;;; align
;;;(add-to-list 'align-rules-list
;;;             '(ruby-comma-delimiter
;;;               (regexp . ",\\(\\s-*\\)[^# \t\n]")
;;;               (repeat . t)
;;;               (modes  . '(ruby-mode))))
;;;(add-to-list 'align-rules-list
;;;             '(ruby-hash-literal
;;;               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
;;;               (repeat . t)
;;;               (modes  . '(ruby-mode))))
;;;(add-to-list 'align-rules-list
;;;             '(ruby-assignment-literal
;;;               (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
;;;               (repeat . t)
;;;               (modes  . '(ruby-mode))))
;;;(add-to-list 'align-rules-list          ;TODO add to rcodetools.el
;;;             '(ruby-xmpfilter-mark
;;;               (regexp . "\\(\\s-*\\)# => [^#\t\n]")
;;;               (repeat . nil)
;;;               (modes  . '(ruby-mode))))


;;;; macros
(my-add-hook 'ruby-mode-hook
          (lambda ()
            (my-load-and-when "_ruby-insert-magic-comment-if-needed")
            (my-add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)))
