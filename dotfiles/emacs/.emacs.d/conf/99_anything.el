(require 'anything-config)

(anything-iswitchb-setup)

(global-set-key "\C-xb" 'anything)
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)


;; anything-dabbrev-expand
(require 'anything-dabbrev-expand)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)

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
                             anything-c-source-locate
                             anything-c-source-complex-command-history
                             anything-c-source-kyr))
