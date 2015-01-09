if [ -f ${HOME}/.bash_login ]; then
  source ${HOME}/.bash_login
fi

# read common environment
if [ -f ${HOME}/.shenv ]; then
  source ${HOME}/.shenv
fi

# read common profile
if [ -f ${HOME}/.profile ]; then
  source ${HOME}/.profile
fi

## include .bashrc if it exists
#if [ -f ${HOME}/.bashrc ]; then
#  source ${HOME}/.bashrc
#fi

# local setting
if [ -f ${HOME}/.bash_profile.`hostname -s`.local ]; then
  source ${HOME}/.bash_profile.`hostname -s`.local
fi
