#!/bin/sh

mount --change-cygdrive-prefix /
mkdir /cygdrive
ln -s /c /cygdrive/c

cygrunsrv --install cron --path /usr/sbin/cron --args -D
cygrunsrv --start cron
