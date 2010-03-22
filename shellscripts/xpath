#!/usr/bin/perl

use strict;
use warnings;
use XML::LibXML;
use XML::XPath::XMLParser;

my $xpath = "$ARGV[0]";

my $parser = XML::LibXML->new;
my $parsed_file = $parser->parse_file($_);
my @nodes = $parsed_file->findnodes($xpath);

foreach $node (@nodes) {
  my $str = XML::XPath::XMLParser::as_string($node);
  print "$str\n";
}
