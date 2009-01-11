## view/edit-file
# http://dev.ariel-networks.com/Members/matsuyama/zsh-peek-file
function view-file() {
  zle -I
  local file
  local -a words

  words=(${(z)LBUFFER})
  file="${words[$#words]}"
  [[ -f "$file" ]] && $PAGER "$file"
}
#zle -N view-file
#bindkey "^x^r" view-file

function edit-file() {
  zle -I
  local file
  local -a words

  words=(${(z)LBUFFER})
  file="${words[$#words]}"
  [[ -f "$file" ]] && $EDITOR "$file"
}
#zle -N edit-file
#bindkey "^x^f" edit-file
