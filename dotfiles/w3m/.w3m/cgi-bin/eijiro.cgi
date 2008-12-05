#!/usr/bin/perl
use strict;
use warnings;
use URI::Escape;

my $word = uri_escape($ENV{'W3M_CURRENT_WORD'});
my $url = "http://eow.alc.co.jp/" . $word . "/UTF-8/";
print <<"EOF";
w3m-control: GOTO $url
w3m-control: DELETE_PREVBUF
EOF
#w3m-control: BACK
