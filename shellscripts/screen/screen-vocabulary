#!/bin/sh

tmp=/tmp/screen-vocabulary.$STY
splited=/tmp/screen-splited.$STY

vocdir=$HOME/english/vocabulary
vocfile="`date '+%Y-%m-%d'`.txt"

trap "" SIGHUP ;

[ ! -p $tmp ] && ( [ -e $tmp ] && rm -fr $tmp ; mkfifo $tmp )
if [ -e $splited ] ; then
    screen -X eval "focus bottom" \
	"select rdic" "msgminwait 0" "hardcopy $tmp"
    case $1 in
	-top)
	screen -X focus top
	;;
	*)
	;;
    esac
    
    i="`sed -e '1d' -e 's/^[^a-zA-Z0-9]*\([^:]*\) :.*/\1/p;d' < $tmp \
	| head -n 1
	`"
    if [ "$i" ] ; then
	echo "$i" >> $vocdir/$vocfile
	screen -X echo "\`\`$i'' registerd into today's vocabulary list"
    else
	screen -X echo "No word/sentence registerd into today's vocabulary list"
    fi
fi
