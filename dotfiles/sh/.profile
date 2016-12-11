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

add_path "/usr/local/bin"
add_path "/usr/local/sbin"
add_path "/opt/local/sbin"
add_path "/opt/local/bin"
add_path "${HOME}/local/bin"
for i in $(find ${HOME}/bin/ -type d -and -not -path "*/.svn*" | sed -e "s/\/\//\//g" | sed -e "s/\/$//"); do
  add_path "$i"
done
add_path "${HOME}/bin"
export PATH


export PS4='+ (${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'
export HOSTNAME="$(hostname -s)"
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#export MAIL="/var/spool/mail/${USERNAME}"
export LESS='--tabs=4 --RAW-CONTROL-CHARS --clear-screen --quit-if-one-screen --LONG-PROMPT --quiet'
export LV='-c -l'
#export EDITOR='vim'
export PAGER='lv'
export HTMLPAGER='w3m -T text/html -dump'
export SVN_EDITOR='vim'
export GIT_EDITOR="$(git var GIT_EDITOR)"
export TERMSCREEN='screen-bce'
#export SSLKEYLOGFILE="${HOME}/sslkey.log"
export XDG_CONFIG_HOME=~/.config

#export GREP_OPTIONS=""
#GREP_OPTIONS="--binary-files=without-match"
#GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
#GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
#if [ -n $(grep --help | grep -q -- --exclude-dir) ]; then
#  GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
#  GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
#  GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
#  GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
#fi
#if [ -n $(grep --help | grep -q -- --color) ]; then
#  GREP_OPTIONS="--color=auto $GREP_OPTIONS"
#fi

# for CPAN
#export PERL5LIB=${HOME}/local/lib/perl5/5.8.8:${HOME}/local/lib/perl5/site_perl/5.8.8
#export PERL_BADLANG=0

# for Python
#export PYTHONPATH="${HOME}/local/lib/python2.7/site-packages"

# for GO
export GOPATH="${HOME}/go"
export GOROOT=/usr/local/opt/go/libexec
PATH="${GOPATH}/bin:${PATH}"

# for Global
if [ -f "${HOME}/bin/gtags-load-libpath" ]; then
    source "${HOME}/bin/gtags-load-libpath"
fi


# OS specific environmental variables
case "${OS}" in
  "Linux")
  export GREP_USE_DFA=1
  export BROWSER='w3m'
  ;;
  "Darwin")
  add_path "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin"
  add_path "/Applications/android-sdk/platform-tools"
  add_path "/Applications/android-sdk/tools"
  add_path "${HOME}/Library/Python/2.7/bin"
  add_path "/usr/local/share/git-core/contrib/diff-highlight"
  export MANPATH="/usr/local/share/man:/opt/local/share/man:/Developer/usr/share/man:/usr/X11/man:/usr/share/man:${MANPATH}"
  export INFOPATH="/opt/local/share/info:/Developer/usr/share/info:/usr/share/info"
  export LANG=ja_JP.UTF-8
  export __CF_USER_TEXT_ENCODING="$(printf "%#x\n" ${UID}):0x8000100:14"
  export JAVA_OPTS='-Dfile.encoding=UTF-8'
  export GTK_PATH=/usr/local/lib/gtk-2.0
  #export RSENSE_HOME="$(brew --prefix rsense)"
  #export PYTHONPATH="$(brew --prefix)/lib/python2.7/site-packages"
  ;;
  "Cygwin")
  add_path -a '/c/meadow/bin'
  add_path -a '/c/Vim'
  add_path -a '/c/strawberry/perl/bin'
  add_path -a '/c/namazu/bin'
  add_path -a '/c/Program\ Files/Subversion/bin'
  add_path -a '/c/Program\ Files/StraceNT'
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


# X
#if [ -x "`which xset`" ]; then
#    xset r on
#    xset r rate 200 80
#fi


# keychain
if [ -x "$(which keychain)" -a -f "${HOME}/.ssh/id_rsa" ]; then
    keychain "${HOME}/.ssh/id_rsa"
    source "${HOME}/.keychain/${HOSTNAME}-sh"
fi


# screen
#if [ "${TERM}" != "${TERMSCREEN}" ]; then
#  screen -D -R
#fi


# rbenv
add_path "${HOME}/.rbenv/bin"
if [ -x "$(which rbenv)" ]; then
  eval "$(rbenv init -)"
fi


# pyenv
add_path "${HOME}/.pyenv/bin"
if [ -x "$(which pyenv)" ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
fi


# nodebrew
if [ -x "$(which nodebrew)" ]; then
  export PATH="${HOME}/.nodebrew/current/bin:${PATH}"
fi


# Node Version Manager (NVM)
if [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
  source "$(brew --prefix nvm)/nvm.sh"
  export NVM_DIR="${HOME}/.nvm"
  mkdir -p ${NVM_DIR}
  nvm use 7.0.0 > /dev/null 2>&1
fi


# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)


# ChefDK
if [ -d "/opt/chefdk/bin" ]; then
  export PATH="/opt/chefdk/bin:${PATH}"
  export UNBUNDLED_COMMANDS="$(ls -1 /opt/chefdk/bin)"
fi


## include .shrc if it exists
#if [ -f ${HOME}/.shrc ]; then
#  source ${HOME}/.shrc
#fi


# local setting
if [ -f "${HOME}/.profile.$(hostname -s).local" ]; then
  source "${HOME}/.profile.$(hostname -s).local"
fi
