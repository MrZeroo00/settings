# include .zshrc if it exists
if [ -f ${HOME}/.zshrc ]; then
    source ${HOME}/.zshrc
fi

# local setting
if [ -f ${HOME}/.zprofile.local ]; then
  source ${HOME}/.zprofile.local
fi
