(require 'filecache)
(file-cache-add-directory-list
 (list "~"))
(define-key minibuffer-local-completion-map
  "\C-c\C-i" 'file-cache-minibuffer-complete)
