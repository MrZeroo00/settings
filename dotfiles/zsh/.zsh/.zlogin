if [ -f ${HOME}/.sh_login ]; then
  source ${HOME}/.sh_login
fi

#ttyctl -f  # freeze the terminal modes... can't change without a ttyctl -u

# local setting
if [ -f ${HOME}/.zsh/.zlogin.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zlogin.`hostname -s`.local
fi
