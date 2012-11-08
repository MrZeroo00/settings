#!/bin/sh

## environmental variables
# set PATH so it includes user's private bin if it exists
function add_path() {
  while getopts "a" flag; do
    case ${flag} in
      \?) OPT_ERROR=1; break;;
      a) opt_append=true;;
    esac
  done

  shift $(( ${OPTIND} - 1 ))

  if [ ${OPT_ERROR} ]; then
    echo "Error in parse options."
    return
  fi

  dir="$1"
  if [ ! -d "${dir}" ]; then
    return
  fi

  if [ "${opt_append}" = "true" ]; then
    PATH="${PATH}:${dir}"
  else
    PATH="${dir}:${PATH}"
  fi
}

add_path "/opt/local/sbin"
add_path "/opt/local/bin"
add_path "${HOME}/local/bin"
for i in `find ${HOME}/bin/ -type d -and -not -path "*/.svn*" | sed -e "s/\/\//\//g"`; do
  add_path "$i"
done
for i in `find ${HOME}/bin/local/ -type d -and -not -path "*/.svn*" | sed -e "s/\/\//\//g"`; do
  add_path "$i"
done
add_path "${HOME}/bin"
export PATH


export HOSTNAME="`hostname -s`"
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#export MAIL=/var/spool/mail/${USERNAME}
#export LESS=-cex4M
export EDITOR='emacsclient -a vim -n'
export PAGER='lv'
export BROWSER='w3m'
export HTMLPAGER='w3m -T text/html -dump'
export SVN_EDITOR='vim'
export GIT_EDITOR='vim'
export TERMSCREEN='screen-bce'

# for CPAN
#export PERL5LIB=${HOME}/local/lib/perl5/5.8.8:${HOME}/local/lib/perl5/site_perl/5.8.8
#export PERL_BADLANG=0

# for Global
if [ -f ${HOME}/bin/gtags-load-libpath ]; then
    source ${HOME}/bin/gtags-load-libpath
fi


# OS specific environmental variables
case "${OS}" in
  "Linux")
  export GREP_USE_DFA=1
  ;;
  "Darwin")
  add_path "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin"
  add_path "/Applications/android-sdk/platform-tools"
  add_path "/Applications/android-sdk/tools"
  export PATH
  export MANPATH="/usr/local/share/man:/opt/local/share/man:/Developer/usr/share/man:/usr/X11/man:/usr/share/man:${MANPATH}"
  export INFOPATH="/opt/local/share/info:/Developer/usr/share/info:/usr/share/info"
  export LANG=ja_JP.UTF-8
  export __CF_USER_TEXT_ENCODING="`printf "%#x\n" ${UID}`:0x8000100:14"
  ;;
  "Cygwin")
  add_path -a '/c/meadow/bin'
  add_path -a '/c/Vim'
  add_path -a '/c/strawberry/perl/bin'
  add_path -a '/c/namazu/bin'
  add_path -a '/c/Program\ Files/Subversion/bin'
  add_path -a '/c/Program\ Files/StraceNT'
  export PATH
  export TERM=cygwin
  export LANG=ja_JP.UTF-8
  export TZ='JST-9'
  export JLESSCHARSET='japanese-sjis'
  mintty-color
  ;;
esac


# locales
#export LC_ALL=${LANG}
export LC_TIME=${LANG}
export LC_MONETARY=${LANG}
export LC_MESSAGES=${LANG}
export LC_CTYPE=${LANG}
export LC_NUMERIC=${LANG}
export LC_COLLATE=${LANG}


# keychain
if [ -x "`which keychain`" ]; then
    keychain ${HOME}/.ssh/id_rsa
    source ${HOME}/.keychain/`uname -n`-sh
fi


# screen
#if [ "${TERM}" != "${TERMSCREEN}" ]; then
#  screen -D -R
#fi


# Ruby Version Manager (RVM)
if [ -s ${HOME}/.rvm/scripts/rvm ]; then
  source ${HOME}/.rvm/scripts/rvm
fi

# Ruby Gems
export GEM_HOME=/var/lib/gems/1.9.0
export RUBYLIB=${RUBYLIB}:/var/lib/gems/1.9.0/lib
export PATH=${PATH}:/var/lib/gems/1.9.0/bin

# Node Version Manager (NVM)
if [ -s ${HOME}/nvm ]; then
  source ${HOME}/nvm/nvm.sh
fi


## include .shrc if it exists
#if [ -f ${HOME}/.shrc ]; then
#  source ${HOME}/.shrc
#fi


# local setting
if [ -f ${HOME}/.profile.`hostname -s`.local ]; then
  source ${HOME}/.profile.`hostname -s`.local
fi
