if [ -f ${HOME}/.sh_login ]; then
  source ${HOME}/.sh_login
fi

#ttyctl -f  # freeze the terminal modes... can't change without a ttyctl -u

# Watch for my friends
#export watch=( $(<~/.friends) )       # watch for people in .friends file
#export watch=(notme)                   # watch for everybody but me
#export LOGCHECK=300                    # check every 5 min for login/logout activity
#export WATCHFMT='%n %a %l from %m at %t.'
#watch="all"
#log

# local setting
if [ -f ${HOME}/.zsh/.zlogin.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zlogin.`hostname -s`.local
fi
