#!/bin/sh

mount --change-cygdrive-prefix /
mkdir /cygdrive
ln -s /c /cygdrive/c

cygrunsrv --install cron --path /usr/sbin/cron --args -D
cygrunsrv --start cron

# tune up
regtool -i set '\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlset\Control\FileSystem\NtfsDisableLastAccessUpdate' 1
