;;;; sense-region
;;;(install-elisp "http://taiyaki.org/elisp/sense-region/src/sense-region.el")
'(my-autoload-and-when 'sense-region-on "sense-region")


;;;; clipboard setting
;;;; http://d.hatena.ne.jp/pakepion/20081209/1228828521
(when (and (or run-linux run-bsd run-unix run-system-v)
           window-system
           (my-which "xsel"))
  (setq interprogram-paste-function
        (lambda ()
          (shell-command-to-string "xsel -b -o")))
  (setq interprogram-cut-function
        (lambda (text &optional rest)
          (let* ((process-connection-type nil)
                 (proc (start-process "xsel" "*Messages*" "xsel" "-b" "-i")))
            (process-send-string proc text)
            (process-send-eof proc)))))


;;;; kill-summary
;;;(install-elisp "http://mibai.tec.u-ryukyu.ac.jp/~oshiro/Programs/elisp/kill-summary.el")
(my-autoload-and-when 'kill-summary "kill-summary"
  (global-set-key "\M-y" 'kill-summary))


;;;; list-register
;;;(install-elisp "http://www.bookshelf.jp/elc/list-register.el")
(my-require-and-when 'list-register)
