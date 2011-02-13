(my-require-and-when 'cc-mode)

;;;; association setting
(add-to-list 'auto-mode-alist '("\\.\\(cc\\|hh\\)\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.[ch]\\(pp\\|xx\\|\\+\\+\\)\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.\\(CC?\\|HH?\\)\\'" . c++-mode))


;; -*-no-byte-compile: t; -*-
