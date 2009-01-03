;(install-elisp-from-emacswiki "anything")
;(install-elisp-from-emacswiki "anything-config")
(require 'anything)
(require 'anything-config)

(anything-iswitchb-setup)

(define-key global-map (kbd "C-;") 'anything)
(define-key global-map (kbd "C-:") 'anything-resume)
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)
(define-key anything-map [end] 'anything-scroll-other-window)
(define-key anything-map [home] 'anything-scroll-other-window-down)
(define-key anything-map [next] 'anything-next-page)
(define-key anything-map [prior] 'anything-previous-page)
(define-key anything-map [delete] 'anything-execute-persistent-action)
(define-key anything-map "\C-\M-v" 'anything-scroll-other-window)
(define-key anything-map "\C-\M-y" 'anything-scroll-other-window-down)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)


;; anything-c-imenu
;(install-elisp-from-emacswiki "el-expectations.el")
(require 'el-expectations)
;(install-elisp "http://www4.atpages.jp/loveloveelisp/anything-c-imenu.el")
(require 'anything-c-imenu)


;; anything-c-linkd-tags
;(install-elisp-from-emacswiki "linkd.el")
(require 'linkd)
;(install-elisp "http://www4.atpages.jp/loveloveelisp/lib/anything-c-linkd-tags.el")
(require 'anything-c-linkd-tags)


;; anything-c-moccur
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
(require 'anything-c-moccur)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
(global-set-key (kbd "C-M-s") 'anything-c-moccur-isearch-forward)
(global-set-key (kbd "C-M-r") 'anything-c-moccur-isearch-backward)


;; anything-c-source-buffers2
;(install-elisp "http://www4.atpages.jp/loveloveelisp/anything-c-source-buffers2.el")
(require 'anything-c-source-buffers2)


;; anything-complete
;(install-elisp-from-emacswiki "anything-complete.el")
(require 'anything-complete)
(anything-lisp-complete-symbol-set-timer 150)


;; anything-dabbrev-expand
;(install-elisp-from-emacswiki "anything-dabbrev-expand.el")
(require 'anything-dabbrev-expand)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)


;; anything-delicious
;(install-elisp "http://trac.codecheck.in/share/browser/lang/elisp/anything-delicious/trunk/anything-delicious.el?format=txt")
;(require 'anything-delicious)


;; anything-grep
;(install-elisp-from-emacswiki "anything-grep.el")
(require 'anything-grep)


;; anything-gtags
;(install-elisp-from-emacswiki "anything-gtags.el")
(require 'anything-gtags)


;; anything-match-plugin
;(install-elisp-from-emacswiki "anything-match-plugin.el")
(require 'anything-match-plugin)


;; anything-migemo
;(install-elisp-from-emacswiki "anything-migemo.el")
(require 'anything-migemo)
(define-key global-map [(control ?:)] 'anything-migemo)


;; anything-rcodetools
;(install-elisp-from-emacswiki "anything-rcodetools.el")
;(require 'anything-rcodetools)
;(setq rct-get-all-methods-command "PAGER=cat fri -l")
;(define-key anything-map "\C-z" 'anything-execute-persistent-action)


;; anything-kyr
(defvar anything-current-buffer nil)
(unless (boundp 'anything-current-buffer)
  (defadvice anything (before get-current-buffer activate)
    (setq anything-current-buffer (current-buffer))))
(defvar anything-kyr-candidates nil)
(defvar anything-kyr-functions nil)
(defvar anything-c-source-kyr
  '((name . "Context-aware Commands")
    (candidates . anything-kyr-candidates)
    (type . command)))
(defvar anything-kyr-commands-by-major-mode nil)
(defun anything-kyr-candidates ()
  (loop for func in anything-kyr-functions
        append (with-current-buffer anything-current-buffer (funcall func))))
(defun anything-kyr-commands-by-major-mode ()
  (assoc-default major-mode anything-kyr-commands-by-major-mode))

;; <<< KYR vars>>>
(setq anything-kyr-commands-by-major-mode
      '((ruby-mode "rdefs" "rcov" "rbtest")
        (emacs-lisp-mode "byte-compile-file"))
      ;;
      anything-kyr-functions
      '(anything-kyr-commands-by-major-mode
        ))

;; anything-c-source-kyr
(setq anything-kyr-functions
      `((lambda ()
          (when (assoc (current-buffer) multiverse-stored-versions)
            (list "multiverse-restore"
                  "multiverse-diff-current" "multiverse-diff-other"
                  "multiverse-forget")))))

(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-man-pages
                             anything-c-source-file-name-history
                             ;anything-c-source-lisp-complete-symbol
                             anything-c-source-locate
                             anything-c-source-complex-command-history
                             anything-c-source-kyr))
