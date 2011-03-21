;;;; simple-hatena-mode
;;;(install-elisp "http://svn.coderepos.org/share/lang/elisp/simple-hatena-mode/trunk/simple-hatena-mode.el")
(my-require-and-when 'simple-hatena-mode
  (setq simple-hatena-bin "~/local/bin/hw.pl")
  (setq simple-hatena-root "~/diary")
;;;  (setq simple-hatena-default-id "your-id")
;;;  (setq simple-hatena-default-group "subtech")
  )


;;;; hatenahelper-mode
;;;; http://d.hatena.ne.jp/amt/20060115/HatenaHelperMode
(my-require-and-when 'hatenahelper-mode
  (global-set-key "\C-xH" 'hatenahelper-mode))
;;;(add-hook 'hatena-mode-hook 'hatenahelper-mode)  ; 本当はこう
;;;(add-hook 'hatena-mode-hook
(defun my-simple-hatena-mode-hook ()
  (hatenahelper-mode t))
(add-hook 'simple-hatena-mode-hook 'my-simple-hatena-mode-hook)


;; -*-no-byte-compile: t; -*-
