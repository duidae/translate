#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

my $filename = "zh_TW-idiot-noheader.po";
open(my $FILE, '<:encoding(UTF-8)', $filename) or die "Cant open file $filename";

while(my $line = <$FILE>) {
	chomp($line);

    if ($line =~ m/^#/) {
    } else {
        if ($line =~ /^msg/) {
            print "\n";
        }
        print "$line";
    }
}
close($FILE);
