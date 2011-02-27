;;;; bookmark
(setq bookmark-default-file "~/.emacs.d/data/.emacs.bmk")


;;;; bookmark-extensions
;;;; http://mercurial.intuxication.org/hg/emacs-bookmark-extension/
'(my-require-and-when 'bookmark-extensions) ;; TODO: fix this.


;;;; bm
;;;; http://www.nongnu.org/bm/
(setq bm-repository-file (expand-file-name "~/.emacs.d/data/.bm-repository"))
(setq bm-repository-size nil)
(setq bm-buffer-persistence t)
;;;; patch for non-X environment
(if (not (functionp 'define-fringe-bitmap))
    (defun define-fringe-bitmap (bitmap bits &optional height width align) (lambda () ())))
(my-require-and-when 'bm
  (global-set-key (kbd "<C-f2>") 'bm-toggle)
  (global-set-key (kbd "<f2>")   'bm-next)
  (global-set-key (kbd "<S-f2>") 'bm-previous))


;;;; goto-chg
;;;(install-elisp-from-emacswiki "goto-chg.el")
'(my-require-and-when 'goto-chg
   (global-set-key [(control ?.)] 'goto-last-change)
   (global-set-key [(control ?,)] 'goto-last-change-reverse))


;;;; saveplace (save cursor position in last edit session)
'(my-require-and-when 'saveplace
   (setq-default save-place t))


;;;; advice
;;; http://0xcc.net/blog/archives/000035.html
'(defadvice bookmark-set (around bookmark-set-ad activate)
   (bookmark-load bookmark-default-file t t) ;; reload latest bookmark before register
   ad-do-it
   (bookmark-save))

'(defadvice bookmark-jump (before bookmark-set-ad activate)
   (bookmark-load bookmark-default-file t t))
'(setq bookmark-save-flag 1)            ; save every time

;;; http://www.emacswiki.org/emacs/BookMarks
'(defadvice bookmark-jump (after bookmark-jump activate)
   (let ((latest (bookmark-get-bookmark bookmark)))
     (setq bookmark-alist (delq latest bookmark-alist))
     (add-to-list 'bookmark-alist latest)))
