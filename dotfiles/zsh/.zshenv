#zmodload zsh/zprof

# This kludge can be used to override some installations that put aliases for
# rm, mv, etc. into the system profiles.  Just be sure to put "unalias alias"
# in your own rc file(s) if you use this.
#alias alias=:

# Some people insist on setting their PATH here to affect things like ssh.
# Those that do should probably use ${SHLVL} to ensure that this only happens
# the first time the shell is started (to avoid overriding a customized
# environment).  Also, the various profile/rc/login files all get sourced
# *after* this file, so they will override this value.  One solution is to
# put your path-setting code into a file named .zpath, and source it from
# both here (if we're not a login shell) and from the .zprofile file (which
# is only sourced if we are a login shell).
#if [[ ${SHLVL} == 1 && ! -o LOGIN ]]; then
#    source ${HOME}/.zpath
#fi

# read common environment
if [ -f ${HOME}/.shenv ]; then
  source ${HOME}/.shenv
fi

# environmental variables
export ZDOTDIR=${HOME}/.zsh
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# autoload
autoload zargs
autoload -Uz is-at-least

# options
setopt extended_history
setopt share_history
#setopt hist_ignore_dups

# local setting
if [ -f ${HOME}/.zshenv.`hostname -s`.local ]; then
  source ${HOME}/.zshenv.`hostname -s`.local
fi
