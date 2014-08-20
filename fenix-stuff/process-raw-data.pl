#!/usr/bin/perl

use strict;
open (INPUTFILE, '<pnp.txt');
open (PNP, '>pnp.clean');

while (<INPUTFILE>)
{

my($line) = $_;
#chomp($line);

$line =~ s/\ //g;
$line =~ s/<\/td>//g;
$line =~ s/<td>/ /g;
#        $line =~ s/&nbsp;//g;
#        $line =~ s/<\/TD><\/TR>//g;
#        $line =~ s/<TR><TD>//g;

my @fields = split / /, $line;
my ($inputrate, $outputrate) = @fields[1, 2];

print "$inputrate\n $outputrate\n";

#print PNP "$tag,$response\n";

}
close (INPUTFILE);

close (PNP);

