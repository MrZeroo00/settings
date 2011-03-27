(my-require-and-when 'cc-mode
  (defun my-c++-mode-after-init-hook ()
    ;; anything
    (when (featurep 'anything)
      (add-to-list 'anything-mode-specific-alist
                   '(c++-mode . (
                                 ;;anything-c-source-yasnippet
                                 anything-c-source-imenu
                                 ;;anything-c-source-gtags-select
                                 ))
                   )
      (add-to-list 'anything-kyr-commands-by-major-mode
                   '(c++-mode
                     recompile
                     compile
                     gtags-find-file
                     gtags-find-rtag
                     ff-find-other-file
                     align
                     highlight-lines-matching-regexp
                     hs-hide-block
                     hs-show-block
                     hide-ifdef-mode
                     develock-mode
                     )
                   )
      )
    )
  (add-hook 'after-init-hook 'my-c++-mode-after-init-hook)
  )


;;;; association setting
(add-to-list 'auto-mode-alist '("\\.\\(cc\\|hh\\)\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.[ch]\\(pp\\|xx\\|\\+\\+\\)\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.\\(CC?\\|HH?\\)\\'" . c++-mode))


;; -*-no-byte-compile: t; -*-
