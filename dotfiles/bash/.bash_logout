if [ -f ${HOME}/.sh_logout ]; then
  source ${HOME}/.sh_logout
fi

# local setting
if [ -f ${HOME}/.bash_logout.`hostname -s`.local ]; then
  source ${HOME}/.bash_logout.`hostname -s`.local
fi
