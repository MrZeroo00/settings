# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi


#if [ -n "${EMACS}" ]; then
#  unsetopt zle
#fi


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
