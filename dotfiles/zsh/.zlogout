if [ -f ${HOME}/.sh_logout ]; then
  source ${HOME}/.sh_logout
fi

# local setting
if [ -f ${HOME}/.zlogout.local ]; then
  source ${HOME}/.zlogout.local
fi
