if [ -f ${HOME}/.sh_logout ]; then
  source ${HOME}/.sh_logout
fi

# local setting
if [ -f ${HOME}/.zsh/.zlogout.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zlogout.`hostname -s`.local
fi
