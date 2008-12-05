#!/bin/sh
# last updated : 2008/03/19 02:44:25 JST
# $Id: polipo-diskcache-check.sh,v 1.2 2008/03/18 18:04:30 yama Exp $
# polipo のキャッシュのあるパーティションの使用率が指定した
# パーセントを越えるとキャッシュを指定したサイズまで削除する。
#

# 設定
# キャッシュのあるディレクトリを指定する。
CacheDir="/var/cache/polipo"
# キャッシュのあるパーティションの使用割合(パーセントで指定する)
LimitDiskSize=84
# 指定サイズまで切り詰める。
CacheSize="1200M"
# polipo_trimcach の指定。
polipo_trimcache="/home/$USER/bin/polipo_trimcache"
#---------------------------------------------------

#echo "初期値は、" $LimitDiskSize "%です。"
while inotifywait -q -q -r -e create $CacheDir ; do
  AB=`df --sync /var | awk '/^\/dev/{sub(/\%/,"", $5);print $5}'`
  if [ $AB -gt $LimitDiskSize ]; then
    nice -n 15 $polipo_trimcache  $CacheDir $CacheSize &> /dev/null
  fi
done
