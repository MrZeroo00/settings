#source $HOME/.zsh/.zsh_antigen
source $HOME/.zsh/.zsh_zplug

## modules
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile


## options
# default
#setopt aliases
#setopt always_last_prompt
#setopt append_history
#setopt auto_list
#setopt auto_menu
#setopt auto_param_keys
#setopt auto_param_slash
#setopt auto_remove_slash
#setopt beep
#setopt case_glob
#setopt clobber
#setopt exec
#setopt flow_control
#setopt glob
#setopt global_rcs
#setopt hash_cmds
#setopt hash_dirs
#setopt hash_list_all
#setopt hist_beep
#setopt list_ambiguous
#setopt list_beep
#setopt list_types
#setopt prompt_cr
#setopt rcs

# zsh default
#setopt bad_pattern
#setopt bang_hist
#setopt bare_glob_qual
#setopt bg_nice
#setopt check_jobs
#setopt equals
#setopt function_argzero
#setopt global_export
#setopt hup
#setopt multios
#setopt nomatch
#setopt notify
#setopt prompt_percent
#setopt short_loops
#setopt unset

setopt auto_cd
#setopt auto_name_dirs
setopt auto_pushd
setopt autoresume
setopt brace_ccl
#setopt chase_dots
#setopt chase_links
setopt complete_aliases
setopt complete_in_word
setopt emacs
setopt extended_glob
setopt extended_history
#setopt glob_assign
#setopt glob_complete
#setopt globdots
#setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
#setopt hist_verify
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
#setopt list_packed
setopt longlistjobs
setopt magic_equal_subst
setopt mailwarning
#setopt mark_dirs
setopt notify
setopt numeric_glob_sort
setopt print_eight_bit
#setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt rc_quotes
setopt rec_exact
setopt share_history
setopt transient_rprompt

unsetopt cdable_vars
unsetopt clobber
unsetopt correct
unsetopt correctall
unsetopt flow_control
unsetopt list_beep
unsetopt longlistjobs
unsetopt promptcr
unsetopt recexact
unsetopt rm_star_silent


## key bindings
#bindkey -v                # vi key bindings
bindkey -e                 # emacs key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand


## disable
disable r


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

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' completer oldlist _complete _match _history _ignored _approximate _prefix

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)
hosts=(`hostname`)
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# use color
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

zstyle ':completion:*' use-cache yes
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/local,/usr}/sbin(N-/))
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"


# User configuration

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# revert history alias
alias history='fc -l'


# read common setting
if [ -f ${HOME}/.shrc ]; then
  source ${HOME}/.shrc
fi


#if [ -n "${EMACS}" ]; then
#  unsetopt zle
#fi

eval "$(direnv hook zsh)"

#mkdir -p ${HOME}/log
#if [ "${TMUX}" != "" ] ; then
#  tmux pipe-pane 'cat >> ${HOME}/log/`date +%Y-%m-%d`_#S:#I.#P.log'
#fi
if [[ ${TERM} = screen ]] || [[ ${TERM} = screen-256color ]]; then
  LOGDIR=${HOME}/log/tmux
  LOGFILE=$(hostname)_$(date +%Y-%m-%d_%H%M%S_%N.log)
  [ ! -d ${LOGDIR} ] && mkdir -p ${LOGDIR}
  tmux set-option default-terminal "screen" \; \
    pipe-pane       "cat >> ${LOGDIR}/${LOGFILE}" \; \
    display-message "Started logging to ${LOGDIR}/${LOGFILE}"
fi

# powerline
#export PATH="${PATH}:${HOME}/Library/Python/2.7/bin"
#powerline-daemon -q
#source ${HOME}/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# function
if [ -f ${HOME}/.zsh/.zsh_function ]; then
  source ${HOME}/.zsh/.zsh_function
fi

# aliases
if [ -f ${HOME}/.zsh/.zsh_aliases ]; then
  source ${HOME}/.zsh/.zsh_aliases
fi

# local setting
if [ -f ${HOME}/.zsh/.zshrc.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zshrc.`hostname -s`.local
fi

#if type zprof > /dev/null 2>&1; then
#  zprof | less
#fi
