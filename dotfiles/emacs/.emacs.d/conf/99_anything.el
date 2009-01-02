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


;; anything-c-moccur
(require 'anything-c-moccur)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
(global-set-key (kbd "C-M-s") 'anything-c-moccur-isearch-forward)
(global-set-key (kbd "C-M-r") 'anything-c-moccur-isearch-backward)


;; anything-complete
(require 'anything-complete)
(anything-lisp-complete-symbol-set-timer 150)


;; anything-dabbrev-expand
(require 'anything-dabbrev-expand)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)


;; anything-gtags
(require 'anything-gtags)


;; anything-migemo
;(require 'anything-migemo)
;(define-key global-map [(control ?:)] 'anything-migemo)


;; anything-rcodetools
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
