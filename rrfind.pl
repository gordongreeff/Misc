#!/usr/bin/perl

$devicename = $ARGV[0];

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
$client->addHeader('x-api-auth', "25fce5e5-3963-2922-b711-b7f165fb3eef");
$devicename .= ".*";
my $start_utc=(time-(10*60));
my $end_utc=time;
my $salt = '100Mmw300twCnRteWoSi1D';# nms salt for fenix
use Digest::MD5 qw(md5_hex);
#https://wiki.is.co.za/index.php/NMS:Performance_Management:Fenix:User_Interfaces:CGI
my $hash =  md5_hex($salt.$filename);

$client->GET("/lookup/rrds?name=$devicename");
print "[http://fenix-gateway.nms.is.co.za/lookup/rrds?name=$devicename\n]";

my $response = from_json($client->responseContent());
my $response_code = $client->responseCode;

print "Response Code [$response_code]\n";
#print "Start time: ", scalar localtime($start_utc),"\n";
#print "End time: ", scalar localtime($end_utc),"\n";
#print "file name: $filename\n";
print &Dumper($response);
