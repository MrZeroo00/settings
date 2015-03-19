# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi

# If not running interactively, don't do anything
[ -z "${PS1}" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "${TERM}" in
xterm-color)
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  ;;
*)
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}[$(date +%Y/%m/%d) \t] \u@\h:\w\$ '
export HISTTIMEFORMAT="[%Y/%m/%d %H:%M:%S] "

# If this is an xterm set the title to user@host:dir
case "${TERM}" in
xterm*|rxvt*)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/${HOME}/~}\007"'
  ;;
*)
  ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# share history
function share_history {
  history -a
  history -c
  history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

# function
if [ -f ${HOME}/.bash_function ]; then
  source ${HOME}/.bash_function
fi

# aliases
if [ -f ${HOME}/.bash_aliases ]; then
  source ${HOME}/.bash_aliases
fi

# local setting
if [ -f ${HOME}/.bashrc.`hostname -s`.local ]; then
  source ${HOME}/.bashrc.`hostname -s`.local
fi
