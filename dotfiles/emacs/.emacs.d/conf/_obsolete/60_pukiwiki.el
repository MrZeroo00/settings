;;;(install-elisp "http://www.bookshelf.jp/pukiwiki/pukiwiki.php?plugin=attach&refer=%A5%A2%A5%A4%A5%C7%A5%A2%BD%B8%2Fpukiwiki-mode&openfile=pukiwiki-mode.el")
(my-autoload-and-when 'pukiwiki-edit "pukiwiki-mode")
(my-autoload-and-when 'pukiwiki-index "pukiwiki-mode")
(my-autoload-and-when 'pukiwiki-edit-url "pukiwiki-mode")

(my-eval-after-load "pukiwiki-mode"
  (setq pukiwiki-site-list
  '(("Dummy" "http://www.example.com/" nil euc-jp-dos)
    ))
  (setq pukiwiki-auto-insert t))
