#!/bin/sh

scriptdir=$HOME/script

plugdir=$scriptdir/news-plugin
plugconf=$plugdir/newslist.conf

NEWS=/tmp/newslist.txt.`who am i | awk '{print $1}'`
TMP=/tmp/newslist2.txt.`who am i | awk '{print $1}'`

toggle=/tmp/screen-news-toggle.`who am i | awk '{print $1}'`

case $1 in

    # ��������
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
    
    # screen(1) �ˤ�륹�ơ������饤��ؤε���ɽ��
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

    # �إ�פ�ɽ��
    -h|--help)
    com=`basename $0`

    echo "��ʹ�θ��Ф��μ����ȱ�����Ԥ��ޤ�"
    echo "usage: $com option [num]"
    echo "Options:"
    echo " -g --get     	���̤ξ�� num �Ԥε������������"
    echo " -s --screen  	�������������� screen(1) �Υ��ơ������Ԥ�ɽ������"
    echo "              	(������̤�����ξ��Ͻ�λ����)"
    echo " -h --help    	�إ�פ�ɽ������"
    ;;
    
    *)

    echo "$com -h �Ȼ��ꤷ�ƥ��ޥ�ɤλȤ������ǧ���Ƥ�������"
esac
