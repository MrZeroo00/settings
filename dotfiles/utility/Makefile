firefox-plugin:
	cd /usr/lib/firefox/plugins && for i in *.so; do sudo ln -s `realpath $i` /usr/local/firefox/plugins/$i; done

supdate:
	cd ~/svn/settings && \
	svn update

aupdate:
	sudo aptitude update && \
	sudo aptitude upgrade

emacs-byte-compile:
	#emacs-snapshot -batch -f batch-byte-compile ~/.emacs.d/elisp/{anything,js2}*.el
	emacs-snapshot -batch -f batch-byte-compile ~/.emacs.d/elisp/js2.el

submit-memo:
	cd ~/memo && \
	git commit -a -m "`date '+%Y/%m/%d'`"

-include ~/Makefile.local
