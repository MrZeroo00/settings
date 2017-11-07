# read common profile
if [ -f ${HOME}/.profile ]; then
  source ${HOME}/.profile
fi


## variables
#TRAPALRM () { zle reset-prompt }
#TMOUT=30
#zmodload zsh/datetime # $EPOCHSECONDS, strftime等を利用可能に
#reset_tmout() { TMOUT=$[60-EPOCHSECONDS%60] }
#precmd_functions=($precmd_functions reset_tmout) # プロンプト表示時に更新までの時間を再計算
#redraw_tmout() { zle reset-prompt; reset_tmout } # 時刻を更新
#TRAPALRM() { redraw_tmout }
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#export cdpath=(.. ~ ~/src ~/zsh)
export DIRSTACKSIZE=20
export MAILCHECK=300
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
export REPORTTIME=3

# Watch for my friends
#export watch=( $(<~/.friends) )       # watch for people in .friends file
#export watch=(notme)                   # watch for everybody but me
#export LOGCHECK=300                    # check every 5 min for login/logout activity
#export WATCHFMT='%n %a %l from %m at %t.'
watch="all"
log

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath


# local setting
if [ -f ${HOME}/.zsh/.zprofile.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zprofile.`hostname -s`.local
fi


# tmux
if [[ -x "$(which tmux)" ]]; then
  if [[ -z $TMUX && -n $PS1 ]]; then
    if $(tmux has-session 2>/dev/null); then
      tmux attach
    else
      tmux -l
    fi
  fi
fi
