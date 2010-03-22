#!/bin/sh

case $1 in
    -*)
    w3m $*
    ;;

    *)
    cd `dirname $1`
    FILE=`basename $1`
    screen -X eval \
	"at w3m stuff \"xTAB_GOTO file:///`pwd`/$FILE\"" \
	"select w3m"
esac
