#!/opt/local/bin/perl

use strict;
use warnings;
use WWW::Mechanize;
use Net::Delicious;
use XML::Feed;
use HTML::Entities;
use YAML::Syck;
use Time::HiRes 'sleep';
use POSIX 'strftime';

sub url_encode($) {
  my $str = shift;
  $str =~ s/([^\w ])/'%'.unpack('H2', $1)/eg;
  $str =~ tr/ /+/;
  return $str;
}

sub get_urls {
  my ($id, $pass, $parse) = @_;

  my $mech = WWW::Mechanize->new();
  $mech->get('https://www.google.com/accounts/ServiceLogin');
  $mech->submit_form(
    form_number => 1,
    #form_id => 'gaia_loginform',
    fields => { Email => $id, Passwd => $pass }
  );
  $mech->get('http://www.google.com/reader/atom/user/-/state/com.google/starred');
  return &$parse($mech->content());
}

sub sbm_urls {
  my ($id, $pass, $urls) = @_;
  my @urls = @$urls;

  # log
  my $now = strftime("%Y%m%d_%H%M%S", localtime);
  open(OUT, ">$ENV{'HOME'}/log/del.icio.us_$now.log");
  binmode(OUT, ":utf8");

  my $res;
  my $real_uri;
  my $mech = WWW::Mechanize->new();
  my $del = Net::Delicious->new( { user => $id, pswd => $pass } );

  foreach my $url (@urls) {
    $mech->get($url->{'link'});
    $real_uri = $mech->uri();
    $res = $del->add_post({ url => $real_uri, description => $url->{'title'}, tags => 'archive', replace => 0 });
    print (OUT "$url->{'title'}\n");
    print (OUT "$url->{'link'}\n");
    print (OUT "$real_uri\n");
    unless ($res) {
      printf(OUT "Error: %s\n", $real_uri);
      printf("Error: %s\n", $real_uri);
    }
    sleep(0.5);
  }
  close(OUT);
}

sub parse {
  my $xml_str = shift;
  my @urls = ();

  my $feed = XML::Feed->parse(\$xml_str);
  foreach my $entry ($feed->entries) {
    push(@urls,
      {
        'title' => decode_entities($entry->title),
        'link' => $entry->link
      });
  }
  return \@urls;
}

my $config = LoadFile($ARGV[0]) || die $!;
my @urls = ();
my $urls = get_urls($config->{'gr_id'}, $config->{'gr_password'}, \&parse);
sbm_urls($config->{'del_id'}, $config->{'del_password'}, $urls);
