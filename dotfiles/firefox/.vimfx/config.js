vimfx.set('config_file_directory', '~/.vimfx')
vimfx.set('hint_chars', 'asdfgwertxcvb')
vimfx.set('prevent_autofocus', true)

vimfx.addKeyOverrides(
  [ location => (location.hostname === "github.com" || location.hostname.match(/^git\..*\.net$/)),
    ['j', 'k', 'l', 's', 't', 'w', 'y', '?']
  ]
)
