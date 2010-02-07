#!/usr/bin/env perl
#
# $Id: nicoget.pl,v 0.2 2007/08/26 12:56:00 dankogai Exp dankogai $
# original: http://yusukebe.com/tech/archives/20070803/124356.html
#

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Cookies;
use HTTP::Request;
use HTTP::Headers;
use CGI;
use YAML::Syck;

my $yaml = "$ENV{HOME}/.nicovideo.yml";
my $conf = YAML::Syck::LoadFile($yaml) or die "$yaml:$!";
$ARGV[0] =~ /(sm\d+)$/ or die "$0 [video_id|uri]";
my $video_id = $1;

my $ua = LWP::UserAgent->new( keep_alive => 1 );
$ua->cookie_jar( {} );

warn "login as $conf->{mail}\n";
$ua->post( "https://secure.nicovideo.jp/secure/login?site=niconico" => $conf );
$ua->get("http://www.nicovideo.jp/watch/$video_id");
my $res = $ua->get("http://www.nicovideo.jp/api/getflv?v=$video_id");
my $q   = CGI->new( $res->content );
my $url = $q->param('url') or die "Failed: " . $res->content;
warn "$url => $video_id.flv\n";
$res = $ua->request( HTTP::Request->new( GET => $url ), "$video_id.flv" );

warn "saving comments as $video_id.xml\n";
my $header = HTTP::Headers->new;
$header->header( Content_Type => 'text/xml' );
my $thread_id = $q->param('thread_id');
my $req       = HTTP::Request->new(
    POST => $q->param('ms'),
    $header,
    qq{<thread res_from="-500" version="20061206" thread="$thread_id" />}
);
$res = $ua->request( $req, "$video_id.xml" );
