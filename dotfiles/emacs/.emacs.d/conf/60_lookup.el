(my-autoload-and-when 'lookup "lookup")
(my-autoload-and-when 'lookup-region "lookup")
(my-autoload-and-when 'lookup-pattern "lookup")

(my-eval-after-load "lookup"
  (setq lookup-search-agents '((ndtp "dserver") (ndspell))))
