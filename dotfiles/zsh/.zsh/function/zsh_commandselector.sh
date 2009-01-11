## zsh_commandselector
# http://journal.mycom.co.jp/column/zsh/016/index.html
for target in txt xml; do
  alias -s ${target}=zsh_pager
done

for target in html xhtml; do
  alias -s ${target}=zsh_browser
done

for target in gif jpg jpeg png bmp; do
  alias -s ${target}=zsh_imageviewer
done

for target in mp3 m4a ogg; do
  alias -s ${target}=zsh_audioplayer
done

for target in mpg mpeg avi mp4v; do
  alias -s ${target}=zsh_movieplayer
done

zsh_pager () {
  $(zsh_commandselector
  "${PAGER} lv less more cat") ${@+"$@"}
}

zsh_browser () {
  $(zsh_commandselector
  "firefox opera konqueror epiphany less") ${@+"$@"}
}

zsh_imageviewer () {
  $(zsh_commandselector
  "gthumb imageviewer gqview kview eog display") ${@+"$@"}
}

zsh_audioplayer () {
  $(zsh_commandselector
  "amarok audacious beep-media-player xmms2 xmms noatun") ${@+"$@"}
}

zsh_movieplayer () {
  $(zsh_commandselector
  "svlc gmplayer totem xine realplay") ${@+"$@"}
}

zsh_commandselector () {
  for command in $(echo ${1})
  do
    if type "${command}" > /dev/null 2>&1
    then
      echo "${command}"
      break
    fi
  done
}
