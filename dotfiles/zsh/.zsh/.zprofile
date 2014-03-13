# read common profile
if [ -f ${HOME}/.profile ]; then
  source ${HOME}/.profile
fi


## modules
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile


## variables
#export LPROMPT="%n@%m%% "
#export PROMPT="${LPROMPT}"
#export RPROMPT="[%~]"
#export SPROMPT="correct: %R -> %r ? "
export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#export cdpath=(.. ~ ~/src ~/zsh)
export DIRSTACKSIZE=20
export MAILCHECK=300
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
export REPORTTIME=3

# Watch for my friends
#export watch=( $(<~/.friends) )       # watch for people in .friends file
#export watch=(notme)                   # watch for everybody but me
#export LOGCHECK=300                    # check every 5 min for login/logout activity
#export WATCHFMT='%n %a %l from %m at %t.'
watch="all"
log

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath


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

case "${OS}" in
  "Darwin")
  #compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
  ;;
esac


# local setting
if [ -f ${HOME}/.zsh/.zprofile.`hostname -s`.local ]; then
  source ${HOME}/.zsh/.zprofile.`hostname -s`.local
fi
