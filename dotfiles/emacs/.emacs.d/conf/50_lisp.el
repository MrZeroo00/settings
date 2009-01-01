(setq load-path (cons "/opt/local/share/emacs/site-lisp/slime" load-path))
(require 'slime-autoloads)
(setq slime-lisp-implementations
      `((sbcl ("/opt/local/bin/sbcl"))
        (clisp ("/opt/local/bin/clisp"))))
(add-hook 'lisp-mode-hook
          (lambda ()
            (cond ((not (featurep 'slime))
                   (require 'slime) 
                   (normal-mode)))))

(eval-after-load "slime"
  '(slime-setup '(slime-fancy slime-banner)))
