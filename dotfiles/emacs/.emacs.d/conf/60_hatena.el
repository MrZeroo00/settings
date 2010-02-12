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
;;;(add-hook 'hatena-mode-hook 'hatenahelper-mode)  ; –{“–‚Í‚±‚¤
;;;(add-hook 'hatena-mode-hook
(add-hook 'simple-hatena-mode-hook
          '(lambda ()
;;;              other hooks must be wrote here!
             (hatenahelper-mode t)))
