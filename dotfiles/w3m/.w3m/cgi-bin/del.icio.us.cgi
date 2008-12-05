#!/usr/bin/ruby
require 'nkf'
require 'cgi'

def esc(s)
  CGI.escape NKF.nkf('-Ew', s || '')
end
title = esc ENV['W3M_TITLE']
url = esc ENV['W3M_URL']
posts = 'https://api.del.icio.us/v1/posts/add'
param = '?description=' + title + '&url=' + url + '&tags=toread&shared=no'
print <<"EOF"
w3m-control: GOTO #{posts}#{param}
w3m-control: DELETE_PREVBUF
w3m-control: BACK
EOF
