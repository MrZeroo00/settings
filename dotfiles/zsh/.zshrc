# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi


#if [ -n "${EMACS}" ]; then
#  unsetopt zle
#fi


# aliases
if [ -f ${HOME}/.zsh_aliases ]; then
  source ${HOME}/.zsh_aliases
fi

# function
if [ -f ${HOME}/.zsh_function ]; then
  source ${HOME}/.zsh_function
fi

# local setting
if [ -f ${HOME}/.zshrc.`hostname -s`.local ]; then
  source ${HOME}/.zshrc.`hostname -s`.local
fi
