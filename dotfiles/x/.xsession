#!/bin/bash --login

xset b off
xset r rate 250 45
xhost +localhost

Esetroot $HOME/etc/wallpaper/01248_plumeriaaftermorningrain_1600x1200.jpg
xcompmgr &

synergys --config $HOME/.synergy.conf --daemon --restart
#synergyc --name alp-tanda_left --display :0.0 K070323-19
#synergyc --name alp-tanda_right --display :0.1 K070323-19
#cairo-clock &
#stardict &
xautolock -secure -locker /usr/bin/xlock -time 3 &
#xscreensaver -no-splash &

gnome-do &

gnome-terminal &
/usr/bin/emacs &
firefox &

awesome || xterm
