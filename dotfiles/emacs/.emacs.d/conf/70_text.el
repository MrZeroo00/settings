;;;; mode hook
(add-hook 'text-mode-hook
          (lambda ()
            (progn
;;;              (ruler-mode)
              (flyspell-mode)
;;;              (refill-mode t)
              )))

;;;; common setting
(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")


;;;; imenu
(add-hook 'text-mode
          (lambda ()
            (progn
              (setq imenu-create-index-function
                  (lambda ()
                    (let (index)
                      (goto-char (point-min))
                      (while (re-search-forward "^\*\s*\\(.+\\)" (point-max) t)
                        (push (cons (match-string 1) (match-beginning 1)) index))
    (nreverse index)))))))


;;;; word-count
;;;(install-elisp "http://taiyaki.org/elisp/word-count/src/word-count.el")
(my-autoload-and-when 'word-count-mode "word-count"
;;;                      (global-set-key "\M-+" 'word-count-mode)
                      )


;;;; text-adjust
;;;(install-elisp "http://taiyaki.org/elisp/text-adjust/src/text-adjust.el")
(add-hook 'text-mode-hook
	  (lambda ()
	    (my-require-and-when 'text-adjust
				 (setq adaptive-fill-regexp "[ \t]*")
				 (setq adaptive-fill-mode t)
				 (setq text-adjust-touten-from nil)
				 (setq text-adjust-kuten-from nil))))

;;;(defun text-adjust-space-before-save-if-needed ()
;;;  (when (memq major-mode
;;;              '(org-mode text-mode mew-draft-mode))
;;;    (text-adjust-space-buffer)))
;;;(defalias 'spacer 'text-adjust-space-buffer)
;;;(add-hook 'before-save-hook 'text-adjust-space-before-save-if-needed)


;;;; manued
;;;; http://www.mpi-inf.mpg.de/~hitoshi/otherprojects/manued/index.shtml
;;;(my-autoload-and-when 'manued-minor-mode "manued")


;;;; macros
;;;(add-hook 'text-mode-hook
;;;          (lambda ()
;;;            (my-load-and-when "text-adjust-space-before-save-if-needed")))
