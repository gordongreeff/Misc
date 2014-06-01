#!/usr/bin/perl

my $filename = $ARGV[0];

use REST::Client;
use JSON;
use Data::Dumper;
use IO::String;
use DateTime;
use Getopt::Long;
use Date::Simple qw(days_in_month);

my $client = REST::Client->new();
$client->setHost("http://fenix-gateway.nms.is.co.za");
$client->addHeader('Content-Type', "application/json");
$client->addHeader('x-api-auth', "XXX-XXX");

my $start_utc=(time-(20*60));
my $end_utc=time;

my $salt = 'XXX-XXX';# nms salt for fenix
use Digest::MD5 qw(md5_hex);
#https://wiki.is.co.za/index.php/NMS:Performance_Management:Fenix:User_Interfaces:CGI
my $hash =  md5_hex($salt.$filename);

$client->GET("/rrd/fetch?filename=$filename&type=report&template=iftraffic&start=$start_utc&end=$end_utc&hash=$hash&resolution=300");
print "[http://fenix-gateway.nms.is.co.za/rrd/fetch?filename=$filename&type=report&template=iftraffic&start=$start_utc&end=$end_utc&hash=$hash]\n";

my $response = from_json($client->responseContent());
my $response_code = $client->responseCode;

print "Response Code [$response_code]\n";
#print "Start time: ", scalar localtime($start_utc),"\n";
#print "End time: ", scalar localtime($end_utc),"\n";
#print "file name: $filename\n";

print &Dumper($response);
