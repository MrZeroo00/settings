# read common environment
if [ -f ${HOME}/.shenv ]; then
  source ${HOME}/.shenv
fi

# include .bashrc if it exists
if [ -f ${HOME}/.bashrc ]; then
  source ${HOME}/.bashrc
fi

# local setting
if [ -f ${HOME}/.bash_profile.local ]; then
  source ${HOME}/.bash_profile.local
fi
