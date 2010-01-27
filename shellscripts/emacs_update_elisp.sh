#!/bin/sh

DIR='/tmp/update_elisp'
mkdir ${DIR}
cd ${DIR}

for i in `grep -h "install-elisp-from-emacswiki" ${HOME}/.emacs.d/conf/* | perl -pe 's/.*"(.*)".*/\1/'`; do
  wget -U Mozilla "http://www.emacswiki.org/emacs/download/$i"
  sleep 1
done

mv ${DIR}/* ${HOME}/.emacs.d/elisp
rm -rf ${DIR}
