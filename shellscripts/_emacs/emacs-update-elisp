#!/bin/sh

DIR='/tmp/update_elisp'
mkdir ${DIR}
cd ${DIR}

for i in `grep -h "install-elisp-from-emacswiki" ${HOME}/.emacs.d/conf/*.el | perl -pe 's/.*"(.*)".*/\1/'`; do
  wget -U Mozilla -t 1 "http://www.emacswiki.org/emacs/download/$i"
  sleep 1
done

for i in `grep -h "install-elisp" ${HOME}/.emacs.d/conf/*.el | grep -v "from-emacswiki" | perl -pe 's/.*"(.*)".*/\1/'`; do
  wget -U Mozilla -t 1 "$i"
  sleep 1
done

mv ${DIR}/* ${HOME}/.emacs.d/elisp
rm -rf ${DIR}
