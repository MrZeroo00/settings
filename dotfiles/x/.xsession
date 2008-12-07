#!/bin/sh

xset b off
xset r rate 250 45
xhost +localhost

Esetroot $HOME/etc/wallpaper/01248_plumeriaaftermorningrain_1600x1200.jpg
xcompmgr &

synergys -f --config $HOME/.synergy.conf &
#synergyc --name alp-tanda_left --display :0.0 K070323-19
#synergyc --name alp-tanda_right --display :0.1 K070323-19
#cairo-clock &
#stardict &
#xautolock -secure -locker /usr/bin/xlock -mode dilemma -time 30 &

gnome-do &

awesome || xterm
