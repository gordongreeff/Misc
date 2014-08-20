#!/usr/bin/perl

use strict;
use LWP::Simple;

#let's open up the input file and the output file for the processed data.
#in theory, the only file that ever needs to be edited is the input file

open (INPUTFILE, '<pnp.input');
open (PNP, '>pnp.txt');

#start a loop to process the input file line by line

while (<INPUTFILE>)
{

chomp;
my($tag,$url) = split;


my($response) = get $url;

#process the HTML response to clear out the badly formatted table

$response =~ s/\ //g;
$response =~ s/<\/td>//g;
$response =~ s/<td>/ /g;

#we only need a few of the fields, so lets split the scrubbed response

my @fields = split / /, $response;
my ($inputrate, $outputrate) = @fields[2, 3];

#lets clean up the variables to make them compatible with Weathermap
$inputrate =~ s/Mbps/M/g;
$outputrate =~ s/Mbps/M/g;

#write to the output file in the correct format for Weathermap

print PNP "$tag,$inputrate,$outputrate\n";

}

#close the open files
close (INPUTFILE);

close (PNP);

#die 'Error getting $url' unless defined $response;
