#!/usr/local/bin/perl

#this is an attemp to rewrite "get-raw-data.pl" to use the RESTful
#interface for fenix.nms.is.coz.a instead of getting the data
#from rrdgraph.cgi using the "view=weathermap" URL which
#only works with a limited number of graph types

use strict;
use REST::Client;
use JSON;
use Data::Dumper;
use Digest::MD5 qw(md5_hex);

#some initial experimeting from the REST::Client documentation

#my $client = REST::Client->new();
#
#       $client->GET('http://fenix.nms.is.co.za/cgi-bin/rrdgraph.cgi?hashhex=d0f3af2a227a0424a2edb0b580831a23&tag=mi-za-cpt-gsrpe2__
ge0-0-4sub708&linetag=mhg-tp-medscheme-cpt-headoffice-neo-mi&type=iftraffic&view=weathermap');
#       print $client->responseContent();
#
# return the data as expected from a standard HTTP server

#most of the code below copied from kaveer.harie@is.co.za

my $client = REST::Client->new();
$client->setHost("http://fenix-gateway.nms.is.co.za");
$client->addHeader('Content-Type', "application/json");
$client->addHeader('x-api-auth', "XXX-XXX");

my $salt = 'XXX-XXX';# nms salt for fenix

#this code searches for a list of matching linetags
#and then prints the entire JSON formatted response
#
my $linetag_search = "vois-med-mhg-.*";
$client->GET("/lookup/linetags?tag=$linetag_search");
my $linetag_list_response = from_json($client->responseContent());
print Dumper($linetag_list_response);

#this code searches for a specific linetag's properties
#and then prints the entire JSON formatted response
#
my $linetag_match = "vois-med-mhg-braam";
$client->GET("/lookup/linetag/$linetag_match");
my $linetag_match_response = from_json($client->responseContent());
print Dumper($linetag_match_response);


# this code uses the previous client response and declares
# variables to use the relevant key/value pairs
#
my $device = $linetag_match_response->{'device'};
my $interface = $linetag_match_response->{'interface'};
print $device . "\n";
print $interface . "\n";

$client->GET("/lookup/linetag/$linetag_match");
my $linetag_match_response = from_json($client->responseContent());
print Dumper($linetag_match_response);

# The code below retrives a list of all possible RRD's
# that match the criteria
#
my $rrdname_guess = $device . "__" . $interface;
print $rrdname_guess . "\n";
$client->GET("/lookup/rrds?name=$rrdname_guess.*");
#$client->GET("/lookup/rrds?name=vo-za-bry-sd2__CA-MED.*");
my $rrd_list_response = from_json($client->responseContent());
print Dumper($rrd_list_response);

# this code uses the previous client response and declares
# variables to use the relevant key/value pairs
#
my $device = $linetag_match_response->{'device'};
my $interface = $linetag_match_response->{'interface'};
print $device . "\n";
print $interface . "\n";

# The code below retrives a list of all possible RRD's
# that match the criteria
#
my $rrdname_guess = $device . "__" . $interface;
print $rrdname_guess . "\n";
$client->GET("/lookup/rrds?name=$rrdname_guess.*");
#$client->GET("/lookup/rrds?name=vo-za-bry-sd2__CA-MED.*");
my $rrd_list_response = from_json($client->responseContent());
print Dumper($rrd_list_response);

# the code below returns the data we actually want to add to the
# weathermap .tsv file for lookus
#
my $filename = "vo-za-bry-sd2__CA-MED-MHG-BRAAM.realmstats.acme.rrd";
my $hash = md5_hex($salt.$filename);
my $rrd_match = "http://fenix-gateway.nms.is.co.za/lookup/rrd/vo-za-bry-sd2__CA-MED-MHG-BRAAM.realmstats.acme.rrd";
#$client->GET("/rrd/graphv?filename=$rrd_match&type=report&template=ifcapacity");
$client->GET("/rrd/graphv?filename=vo-za-bry-sd2__CA-MED-MHG-BRAAM.realmstats.acme.rrd&template=ifcapacity&hashhex=$hash");
my $rrd_match = from_json($client->responseContent());
print Dumper($rrd_match);

#http://fenix-gateway.nms.is.co.za/rrd/graphv?filename=mi-za-grg-pe2__s1-5chan29.interface.netIf.rrd&type=report&template=ifcapacity
