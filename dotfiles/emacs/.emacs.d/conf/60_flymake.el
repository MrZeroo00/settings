(require 'flymake)

(global-set-key "\C-cd" 'flymake-display-err-menu-for-current-line)

(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))
