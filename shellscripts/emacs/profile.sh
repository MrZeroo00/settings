#!/bin/sh

for i in `ls ${HOME}/.emacs.d/conf/*.el`; do
  elisp=`echo $i | perl -pe "s/.*\/(.*)\.el/\1/"`
  echo $elisp
  emacsclient -e "(my-load-and-when \"${elisp}\")"
  time emacsclient -e '(load-test "foo\nbar\nbaz" 10000)'
done
