;(install-elisp-from-emacswiki "anything.el")
;(install-elisp-from-emacswiki "anything-config.el")
;(install-elisp-from-emacswiki "anything-show-completion.el")
(my-require-and-when 'anything)
(my-require-and-when 'anything-config)
;(my-load-and-when "_anything-rubikitch")

(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0)
(setq anything-candidate-number-limit 100)
(setq anything-show-completion-activate nil)
;(setq anything-c-locate-db-file "~/home.locatedb")
;(setq anything-c-locate-options `("locate" "-d" ,anything-c-locate-db-file "-i" "-r" "--"))
(setq anything-candidate-separator
      "------------------------------------------------------------------------------------")

;(anything-iswitchb-setup)

; key setting
(define-key global-map (kbd "C-;") 'anything)
(define-key global-map (kbd "C-:") 'anything-resume)
(define-key global-map (kbd "C-'") 'anything-call-source)
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
(my-require-and-when 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)


;; anything-c-imenu
;(install-elisp-from-emacswiki "el-expectations.el")
(my-require-and-when 'el-expectations)
;(install-elisp "http://www4.atpages.jp/loveloveelisp/anything-c-imenu.el")
(my-require-and-when 'anything-c-imenu)


;; anything-c-linkd-tags
;(install-elisp-from-emacswiki "linkd.el")
(my-require-and-when 'linkd)
;(install-elisp "http://www4.atpages.jp/loveloveelisp/lib/anything-c-linkd-tags.el")
(my-require-and-when 'anything-c-linkd-tags)


;; anything-c-lisp-complete-symbol
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-lisp-complete-symbol/anything-c-lisp-complete-symbol.el")
(my-require-and-when 'anything-c-lisp-complete-symbol)


;; anything-c-moccur
;(install-elisp "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
(my-require-and-when 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.1)
(setq anything-c-moccur-enable-initial-pattern t)
(setq anything-c-moccur-higligt-info-line-flag t)
(setq anything-c-moccur-enable-auto-look-flag t)
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
(my-require-and-when 'anything-c-source-buffers2)


;; anything-c-yasnippet
(my-require-and-when 'anything-c-yasnippet)
(setq anything-c-yas-space-match-any-greedy t)


;; anything-complete
;(install-elisp-from-emacswiki "anything-complete.el")
(my-require-and-when 'anything-complete)
(anything-read-string-mode t)
(anything-lisp-complete-symbol-set-timer 150)
(setq anything-lisp-complete-symbol-input-idle-delay 0.0)
(setq anything-find-file-additional-sources (list anything-find-file-additional-sources
                                                  (if run-darwin
                                                      anything-c-source-mac-spotlight
                                                    anything-c-source-locate)))


;; anything-dabbrev-expand
;(install-elisp-from-emacswiki "anything-dabbrev-expand.el")
(my-require-and-when 'anything-dabbrev-expand)
(setq anything-dabbrev-input-idle-delay 0.0)
(setq anything-dabbrev-idle-delay 1.0)
(setq anything-dabbrev-expand-candidate-number-limit 20)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)


;; anything-delicious
;(install-elisp "http://trac.codecheck.in/share/browser/lang/elisp/anything-delicious/trunk/anything-delicious.el?format=txt")
;(my-require-and-when 'anything-delicious)


;; anything-emms
;(install-elisp-from-emacswiki "anything-emms.el")
;(my-require-and-when 'anything-emms)


;; anything-extension
;(install-elisp-from-emacswiki "anything-extension.el")
;(my-require-and-when 'anything-extension)


;; anything-grep
;(install-elisp-from-emacswiki "anything-grep.el")
(my-require-and-when 'anything-grep)

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
(my-require-and-when 'anything-gtags)
(setq anything-gtags-classify t)
(setq anything-gtags-enable-goto-location t)


;; anything-match-plugin
;(install-elisp-from-emacswiki "anything-match-plugin.el")
(my-require-and-when 'anything-match-plugin)
(setq anything-mp-space-regexp "[\\ ] ")


;; anything-migemo
;(install-elisp-from-emacswiki "anything-migemo.el")
(my-require-and-when 'anything-migemo)
(define-key global-map [(control ?:)] 'anything-migemo)


;; anything-rcodetools
;(install-elisp-from-emacswiki "anything-rcodetools.el")
;(my-require-and-when 'anything-rcodetools)
;(setq rct-get-all-methods-command "PAGER=cat fri -l")
;(define-key anything-map "\C-z" 'anything-execute-persistent-action)


;; descbinds-anything
;(install-elisp-from-emacswiki "descbinds-anything.el")
(my-require-and-when 'descbinds-anything)
(descbinds-anything-install)


;; anything-c-key-chord-describe
(my-load-and-when "_anything-c-key-chord-describe")


;; anything-call-source


;; anything-compile-source--candidates-file
(defvar anything-c-source-home-directory
  '((name . "Home directory")
    ;; /log/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
    (candidates-file "/log/home.filelist" updating)
    (requires-pattern . 5)
    (candidate-number-limit . 20)
    (type . file)))


;; anything-kyr
(my-require-and-when 'anything-kyr-config)
(my-require-and-when 'anything-complete
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
                             anything-c-source-yasnippet
                             ;anything-c-source-man-pages
                             ;anything-c-source-info-pages
                             anything-c-source-imenu
                             ;anything-c-source-gtags-select
                             anything-c-source-file-name-history
                             anything-c-source-file-cache
                             ;(if run-darwin
                             ;    anything-c-source-mac-spotlight
                             ;  anything-c-source-locate)
                             ;anything-c-source-calculation-result
                             ;anything-c-source-complex-command-history
                             ))


;; advice
(defadvice anything (around disable-ww-mode activate)
  (ad-deactivate-regexp "widen-window")
  (unwind-protect
      ad-do-it
    (ad-activate-regexp "widen-window")))

;; patches
(setq fit-frame-inhibit-fitting-flag t)
(setq anything-save-configuration-functions '(set-window-configuration . current-window-configuration))
