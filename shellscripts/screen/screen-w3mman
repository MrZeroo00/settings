#!/bin/sh

if [ x"$1" != x"-b" ] ; then
    window="w3m"    
fi

case $1 in 
    [0-9])
    [ x"$2" = x ] && exit
    QUERY="man=$2&section=$1"
    ;;

    [0-9a-zA-Z][0-9a-zA-Z]*)
    QUERY="man=$1"
    ;;

    -k)
    QUERY="keyword=$2"
    ;;

    -i)
    ;;

    *)
    exit
    ;;
esac

screen -X eval \
    "at w3m stuff \"xTAB_GOTO file:///cgi-bin/w3mman2html.cgi?$QUERY\"" \
    "select $window"
