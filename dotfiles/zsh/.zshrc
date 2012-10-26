# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi


#if [ -n "${EMACS}" ]; then
#  unsetopt zle
#fi

if [ ! -f ${HOME}/.zsh/cdd_pwd_list ]; then
  mkdir ${HOME}/.zsh
  touch ${HOME}/.zsh/cdd_pwd_list
fi


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
