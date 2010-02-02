if [ -f ${HOME}/.sh_login ]; then
  source ${HOME}/.sh_login
fi

#ttyctl -f  # freeze the terminal modes... can't change without a ttyctl -u

# local setting
if [ -f ${HOME}/.zlogin.local ]; then
  source ${HOME}/.zlogin.local
fi
