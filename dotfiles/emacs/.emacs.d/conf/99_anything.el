;(install-elisp-from-emacswiki "anything.el")
;(install-elisp-from-emacswiki "anything-config.el")
;(install-elisp-from-emacswiki "anything-show-completion.el")
(require 'anything)
(require 'anything-config)

(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit 100)
;(setq anything-c-locate-db-file "~/home.locatedb")
;(setq anything-c-locate-options `("locate" "-d" ,anything-c-locate-db-file "-i" "-r" "--"))
(setq anything-candidate-separator
      "------------------------------------------------------------------------------------")

;(anything-iswitchb-setup)

; key setting
(define-key global-map (kbd "C-;") 'anything)
(define-key global-map (kbd "C-:") 'anything-resume)
;(define-key anything-map "\M-N" 'anything-next-source)
;(define-key anything-map "\M-P" 'anything-previous-source)
(define-key anything-map "\C-\M-n" 'anything-next-source)
(define-key anything-map "\C-\M-p" 'anything-previous-source)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)
(define-key anything-map "\C-s" 'anything-isearch)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
(define-key anything-map "\C-i" 'anything-select-action)
(define-key anything-map "\C-\M-v" 'anything-scroll-other-window)
(define-key anything-map "\C-\M-y" 'anything-scroll-other-window-down)
(define-key anything-map "\C-r" 'anything-select-source)


;; ac-anything
;(install-elisp-from-emacswiki "ac-anything.el")
;(require 'ac-anything)
;(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)


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


;; anything-c-lisp-complete-symbol
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-lisp-complete-symbol/anything-c-lisp-complete-symbol.el")
(require 'anything-c-lisp-complete-symbol)


;; anything-c-moccur
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
(require 'anything-c-moccur)
(setq anything-c-moccur-enable-initial-pattern t)
(setq anything-c-moccur-anything-idle-delay 0.1)
;(defalias 'aoccur 'anything-c-moccur-occur-by-moccur)
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


;; anything-c-yasnippet
(require 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t)


;; anything-complete
;(install-elisp-from-emacswiki "anything-complete.el")
(require 'anything-complete)
(anything-read-string-mode t)
(anything-lisp-complete-symbol-set-timer 150)
(setq anything-lisp-complete-symbol-input-idle-delay 0.0)


;; anything-dabbrev-expand
;(install-elisp-from-emacswiki "anything-dabbrev-expand.el")
(require 'anything-dabbrev-expand)
(setq anything-dabbrev-input-idle-delay 0.0)
(setq anything-dabbrev-idle-delay 1.0)
(setq anything-dabbrev-expand-candidate-number-limit 20)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)


;; anything-delicious
;(install-elisp "http://trac.codecheck.in/share/browser/lang/elisp/anything-delicious/trunk/anything-delicious.el?format=txt")
;(require 'anything-delicious)


;; anything-grep
;(install-elisp-from-emacswiki "anything-grep.el")
(require 'anything-grep)

(setq anything-grep-goto-hook
      (lambda ()
        (when anything-in-persistent-action
          (anything-persistent-highlight-point (point-at-bol) (point-at-eol)))))

(setq anything-grep-alist
      ;; 全バッファのファイル名においてegrepをかける。moccurの代わり。
      '(("buffers" ("egrep -Hin %s $buffers" "/"))
        ;; ~/memo 以下から再帰的にegrepをかける。不要なファイルは除かれる。
        ("memo" ("ack-grep -af | xargs egrep -Hin %s" "~/memo"))
        ;; grep current directory (now testing)
        ("current directory" ("ack-grep -af | xargs egrep -Hin %s" "."))
        ;; ~/ruby以下の全Rubyスクリプトと~/bin以下のファイルをまとめて検索する。
        ("~/bin and ~/ruby"
         ("ack-grep -afG 'rb$' | xargs egrep -Hin %s" "~/ruby")
         ("ack-grep -af | xargs egrep -Hin %s" "~/bin"))))


;; anything-gtags
;(install-elisp-from-emacswiki "anything-gtags.el")
(require 'anything-gtags)
(setq anything-gtags-classify t)


;; anything-match-plugin
;(install-elisp-from-emacswiki "anything-match-plugin.el")
(require 'anything-match-plugin)
(setq anything-mp-space-regexp "[\\ ] ")


;; anything-migemo
;(install-elisp-from-emacswiki "anything-migemo.el")
(require 'anything-migemo)
(define-key global-map [(control ?:)] 'anything-migemo)


;; anything-rcodetools
;(install-elisp-from-emacswiki "anything-rcodetools.el")
;(require 'anything-rcodetools)
;(setq rct-get-all-methods-command "PAGER=cat fri -l")
;(define-key anything-map "\C-z" 'anything-execute-persistent-action)


;; descbinds-anything
;(install-elisp-from-emacswiki "descbinds-anything.el")
(require 'descbinds-anything)
(descbinds-anything-install)


;; anything-c-bm
(load "_anything-c-bm")


;; anything-c-key-chord-describe
(load "_anything-c-key-chord-describe")


;; anything-call-source


;; anything-compile-source--candidates-file
(defvar anything-c-source-home-directory
  '((name . "Home directory")
    ;; /log/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
    (candidates-file "/log/home.filelist" updating)
    (requires-pattern . 5)
    (candidate-number-limit . 20)
    (type . file)))


;; anything-select-source
(load "_anything-select-source")


;; anything-kyr
(require 'anything-kyr-config)
(when (require 'anything-complete nil t)
  (anything-read-string-mode 1))

(setq anything-kyr-commands-by-major-mode
      '((c-mode "recompile" "compile"
                "gtags-find-file" "gtags-find-rtag"
                "ff-find-other-file" "align"
                "develock-mode" "highlight-lines-matching-regexp"
                "hs-hide-block" "hs-show-block"
                "hide-ifdef-mode")
        (ruby-mode "rdefs" "rcov" "rbtest")
        (emacs-lisp-mode "byte-compile-file"))
      anything-kyr-commands-by-major-mode)


(setq anything-sources (list anything-c-source-kyr
                             anything-c-source-buffers
                             anything-c-source-bm
                             ;anything-c-source-bookmarks
                             ;anything-c-source-man-pages
                             ;anything-c-source-info-pages
                             anything-c-source-file-name-history
                             anything-c-source-file-cache
                             (if run-darwin
                                 anything-c-source-mac-spotlight
                               anything-c-source-locate)
                             ;anything-c-source-calculation-result
                             anything-c-source-complex-command-history
                             ))


;; advice
(defadvice anything (around disable-ww-mode activate)
  (ad-deactivate-regexp "widen-window")
  (unwind-protect
      ad-do-it
    (ad-activate-regexp "widen-window")))
