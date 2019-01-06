#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

# build key value hash map
my $filename = "idiot-key-value.po";
open(my $FILE, '<:encoding(UTF-8)', $filename) or die "Cant open file $filename";

my %hash = ();

my $msg = '';
my $status = '';
while(my $line = <$FILE>) {
	chomp($line);

    if ($line =~ /^msgid/) { # msgid
        $status = 'msgid';
        $line =~ s/^msgid //;
        $msg = lc($line);
    } elsif ($line =~ /^msgstr/) { # msgstr
        $status = 'msgstr';
        $line =~ s/^msgstr //;
        push @{$hash{$msg}}, $line;
    } elsif (length($line)) {
        if ($status eq 'msgid') {
            $line =~ s/\"//g;
            $msg = $msg . lc($line);
        } elsif ($status eq 'msgstr') {
            push @{$hash{$msg}}, $line;
        } else {
            print "Warning: Unknown field $status\n";
        }
    }    
}
close($FILE);

foreach my $key (keys %hash) {
    print "key: $key\n";
    foreach my $value (@{$hash{$key}}) {
        print "value: $value ";
    }
    print "\n";
}

# insert to target