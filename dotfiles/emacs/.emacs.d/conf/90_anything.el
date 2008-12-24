(require 'anything-config)

(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-man-pages
                             anything-c-source-file-name-history
                             anything-c-source-locate
                             anything-c-source-complex-command-history
                             anything-c-source-kyr))
(anything-iswitchb-setup)

(global-set-key "\C-xb" 'anything)
(define-key anything-map (kbd "C-M-n") 'anything-next-source)
(define-key anything-map (kbd "C-M-p") 'anything-previous-source)


;; anything-dabbrev-expand
(require 'anything-dabbrev-expand)
(global-set-key "\M-/" 'anything-dabbrev-expand)
(define-key anything-dabbrev-map "\M-/" 'anything-dabbrev-find-all-buffers)

;; anything-c-source-kyr
(setq anything-kyr-functions
      `((lambda ()
          (when (assoc (current-buffer) multiverse-stored-versions)
            (list "multiverse-restore"
                  "multiverse-diff-current" "multiverse-diff-other"
                  "multiverse-forget")))
