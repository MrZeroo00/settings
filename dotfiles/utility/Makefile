firefox-plugin:
	cd /usr/lib/firefox/plugins && for i in *.so; do sudo ln -s `realpath $i` /usr/local/firefox/plugins/$i; done

supdate:
	cd ~/svn/settings && \
	svn update

aupdate:
	sudo aptitude update && \
	sudo aptitude upgrade
