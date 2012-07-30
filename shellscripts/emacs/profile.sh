#!/bin/sh

for i in `ls ${HOME}/.emacs.d/conf/*.el`; do
  elisp=`echo $i | perl -pe "s/.*\/(.*)\.el/\1/"`
  echo $elisp
  emacsclient -e "(my-load-and-when \"${elisp}\")"
  sleep 1
  time emacsclient -e '(load-test "if\nfor\nwhile" 100000)'
  sleep 1
done
