#!/bin/sh

scriptdir=$HOME/script

plugdir=$scriptdir/news-plugin
plugconf=$plugdir/newslist.conf

NEWS=/tmp/newslist.txt.`who am i | awk '{print $1}'`
TMP=/tmp/newslist2.txt.`who am i | awk '{print $1}'`

toggle=/tmp/screen-news-toggle.`who am i | awk '{print $1}'`

case $1 in

    # 記事取得
    -g|--get)
    
    (
	[ -f $TMP ] && rm $TMP
	
	if [ -f $plugconf ] ; then
	    while read i ; do
		sh $plugdir/$i >> $TMP
	    done < $plugconf
	fi

	[ -f $TMP ] && mv $TMP $NEWS
    )
    ;;
    
    # screen(1) によるステータスラインへの記事表示
    -s|--screen)
    
    trap "" SIGHUP
    trap "[ -f $toggle ] && rm $toggle ; exit " INT

    if [ -f $toggle ] ; then
	rm $toggle
    else 
	(
	    touch $toggle	
	    while [ -f $NEWS ] ; do
		while read i ; do
		    headline=`echo $i | sed 's/,http:.*//'`

		    if [ ! -f $toggle ] ; then
			screen -X echo ' Headline news terminated' 
			exit
		    fi
		    screen -X eval "msgwait 5" "msgminwait 0" "echo \"$headline\""
		    sleep 3

		    if [ ! -f $toggle ] ; then
			screen -X echo ' Headline news terminated' 
			exit
		    fi
		    screen -X echo "$headline"
		    sleep 3

		done < $NEWS 
	    done 
	) &
    fi
    ;;

    # ヘルプの表示
    -h|--help)
    com=`basename $0`

    echo "新聞の見出しの取得と閲覧を行います"
    echo "usage: $com option [num]"
    echo "Options:"
    echo " -g --get     	各面の上位 num 行の記事を取得する"
    echo " -s --screen  	取得した記事を screen(1) のステータス行へ表示する"
    echo "              	(記事が未取得の場合は終了する)"
    echo " -h --help    	ヘルプを表示する"
    ;;
    
    *)

    echo "$com -h と指定してコマンドの使い方を確認してください"
esac
