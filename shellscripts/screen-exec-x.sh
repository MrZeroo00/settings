#!/bin/sh

trap "" SIGHUP
case $1 in 
    -fg)
    exec $2 > /dev/null 2>&1
    ;;
    -bg)
    shift 1
    exec $* > /dev/null 2>&1 &
    ;;
    *)
    exec $* > /dev/null 2>&1 &
esac
