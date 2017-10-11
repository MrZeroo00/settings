#
# Generic .zshenv file for zsh
#
# .zshenv is sourced on ALL invocations of the shell, unless the -f option is
# set.  It should NOT normally contain commands to set the command search path,
# or other common environment variables unless you really know what you're
# doing.  E.g. running "PATH=/custom/path gdb program" sources this file (when
# gdb runs the program via ${SHELL}), so you want to be sure not to override a
# custom environment in such cases.  Note also that .zshenv should not contain
# commands that produce output or assume the shell is attached to a tty.
#

#zmodload zsh/zprof

# THIS FILE IS NOT INTENDED TO BE USED AS /etc/zshenv, NOR WITHOUT EDITING
#return 0	# Remove this line after editing this file as appropriate

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

## completion
# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
for d in "/share/zsh-completions" "/share/zsh/zsh-site-functions"; do
  brew_completion=$(brew --prefix 2>/dev/null)$d
  if [ $? -eq 0 ] && [ -d "$brew_completion" ]; then
    fpath=($brew_completion $fpath)
  fi
done
autoload -U compinit
if [ "${OS}" != "Cygwin" ]; then
  compinit
else
  compinit -u
fi

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
