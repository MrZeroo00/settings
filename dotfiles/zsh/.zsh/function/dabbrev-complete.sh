## dabbrev
# http://d.hatena.ne.jp/secondlife/20060108/1136650653
HARDCOPYFILE=$HOME/tmp/screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
  local reply lines=80 # 80行分
  screen -X eval "hardcopy -h $HARDCOPYFILE"
  reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
  compadd - "${reply[@]%[*/=@|]}"
}

#zle -C dabbrev-complete menu-complete dabbrev-complete
#bindkey '^o' dabbrev-complete
#bindkey '^o^_' reverse-menu-complete
