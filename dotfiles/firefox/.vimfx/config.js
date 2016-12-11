vimfx.set('config_file_directory', '~/.vimfx')
vimfx.set('hint_chars', 'asdfgwertxcvb')
vimfx.set('prevent_autofocus', true)

vimfx.addKeyOverrides(
  [ location => location.hostname === 'github.com',
    ['j', 'k', 't']
  ]
)
