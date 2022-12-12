use strict;
use warnings;

# SILENT LISTEN

my $silent = "SILENT";
my $listen = "LISTEN";

my @silent = split("", $silent);
my %silent = map { $_ => 1 } @silent;
my @silentKeys = sort keys %silent;

my @listen = split("", $listen);
my %listen = map { $_ => 1 } @listen;
my @listenKeys = sort keys %listen;

if(scalar @listenKeys == scalar @silentKeys) {
    if( @listenKeys ~~ @silentKeys) {
        print "anagrams";
    }
    else {
        print "not anagrams";
    }
} else {
    print "not anagrams";
}

