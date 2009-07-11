#!/bin/sh
$HOME/script/screen-split.sh -o  
stty cs8 -istrip -parenb
exec w3m -title
