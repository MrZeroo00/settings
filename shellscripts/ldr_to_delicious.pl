#!/opt/local/bin/perl

use strict;
use warnings;
use WWW::Mechanize;
use Net::Delicious;
use JSON;
use YAML::Syck;
use Time::HiRes 'sleep';
use POSIX 'strftime';

sub url_encode($) {
  my $str = shift;
  $str =~ s/([^\w ])/'%'.unpack('H2', $1)/eg;
  $str =~ tr/ /+/;
  return $str;
}

sub get_pins {
  my ($id, $pass) = @_;

  my $mech = WWW::Mechanize->new();
  $mech->get('http://reader.livedoor.com/reader/');
  $mech->submit_form(
    form_name => 'loginForm',
    fields => { livedoor_id => $id, password => $pass }
  );
  $mech->post("http://reader.livedoor.com/api/pin/all");
  return from_json($mech->content( format => 'text' ));
}

sub sbm_pins {
  my ($id, $pass, $pin_output) = @_;

  # log
  my $now = strftime "%Y%m%d_%H%M%S", localtime;
  open(OUT, ">$now.log");
  binmode(OUT, ":utf8");

  my $res;
  my $real_uri;
  my $mech = WWW::Mechanize->new();
  my $del = Net::Delicious->new( { user => $id, pswd => $pass } );

  my @pins = @{$pin_output};
  foreach my $pin (@pins) {
    $mech->get($pin->{'link'});
    $real_uri = $mech->uri();
    $res = $del->add_post({ url => $real_uri, description => $pin->{'title'}, tags => 'archive', replace => 0 });
    print OUT "$pin->{'title'}\n";
    print OUT "$pin->{'link'}\n";
    print OUT "$real_uri\n";
    unless ($res) {
      printf("Error: %s\n", $real_uri);
    }
    sleep(0.5);
  }
  close(OUT);
}

my $config = LoadFile($ARGV[0]) || die $!;
my $pin_output = get_pins($config->{'ldr_id'}, $config->{'ldr_password'});
sbm_pins($config->{'del_id'}, $config->{'del_password'}, $pin_output);
