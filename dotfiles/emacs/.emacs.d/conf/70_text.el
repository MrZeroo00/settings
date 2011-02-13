;;;; imenu
'(setq imenu-create-index-function
      (lambda ()
        (let (index)
          (goto-char (point-min))
          (while (re-search-forward "^\*\s*\\(.+\\)" (point-max) t)
            (push (cons (match-string 1) (match-beginning 1)) index))
          (nreverse index))))


;;;; text-adjust
;;;(install-elisp "http://taiyaki.org/elisp/text-adjust/src/text-adjust.el")
'(my-require-and-when 'text-adjust
  (setq adaptive-fill-regexp "[ \t]*")
  (setq adaptive-fill-mode t)
  (setq text-adjust-touten-from nil)
  (setq text-adjust-kuten-from nil)
  (defun text-adjust-space-before-save-if-needed ()
    (when (memq major-mode
                '(org-mode text-mode mew-draft-mode))
      (text-adjust-space-buffer)))
  (defalias 'spacer 'text-adjust-space-buffer)
  (add-hook 'before-save-hook 'text-adjust-space-before-save-if-needed))


;;;; word-count
;;;(install-elisp "http://taiyaki.org/elisp/word-count/src/word-count.el")
'(my-autoload-and-when 'word-count-mode "word-count"
  (global-set-key "\M-+" 'word-count-mode)
  )


;;;; manued
;;;; http://www.mpi-inf.mpg.de/~hitoshi/otherprojects/manued/index.shtml
;;;(my-autoload-and-when 'manued-minor-mode "manued")


;;;; mode hook
(defun my-text-mode-hook ()
  ;; common setting
  '(ruler-mode)
  (flyspell-mode)
  '(refill-mode t)
  '(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

  ;; macros
  '(my-load-and-when "text-adjust-space-before-save-if-needed")
  )
(add-hook 'text-mode-hook 'my-text-mode-hook)


;; -*-no-byte-compile: t; -*-
