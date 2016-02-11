#source $HOME/.zsh/.zsh_antigen
source $HOME/.zsh/.zsh_zplug

# User configuration

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# revert history alias
alias history='fc -l'


# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi


#if [ -n "${EMACS}" ]; then
#  unsetopt zle
#fi

eval "$(direnv hook zsh)"

mkdir -p ${HOME}/log
if [ "${TMUX}" != "" ] ; then
  tmux pipe-pane 'cat >> ${HOME}/log/`date +%Y-%m-%d`_#S:#I.#P.log'
fi

# powerline
#export PATH="${PATH}:${HOME}/Library/Python/2.7/bin"
#powerline-daemon -q
#source ${HOME}/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# function
if [ -f ${HOME}/.zsh/.zsh_function ]; then
  source ${HOME}/.zsh/.zsh_function
fi

# aliases
if [ -f ${HOME}/.zsh/.zsh_aliases ]; then
  source ${HOME}/.zsh/.zsh_aliases
fi

# local setting
if [ -f ${HOME}/.zsh/.zshrc.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zshrc.`hostname -s`.local
fi

#if type zprof > /dev/null 2>&1; then
#  zprof | less
#fi
