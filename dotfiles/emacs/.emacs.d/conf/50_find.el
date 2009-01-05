; for coding
(setq grep-find-command "find . -type f ! -name '*,v' ! -name '*~' ! -name '*.o' ! -name '*.a' ! -name '*.so' ! -name '*.class' ! -name '*.jar' ! -name 'semantic.cache' ! -path '*.deps*' ! -path '*/obsolete/*' ! -path '*/.svn/*' ! -path '*/CVS/*' -print0 | xargs -0 -e grep -n -e ")


;; http://dev.ariel-networks.com/Members/matsuyama/isearch-selected-text
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active)
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))
