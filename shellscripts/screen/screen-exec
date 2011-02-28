#!/bin/sh
com=`echo $1 | tr a-z A-Z`

screen -X eval 'msgminwait 0' "echo \"$com executed\""
$1
screen -X eval "kill" "echo '$com terminated'" 


