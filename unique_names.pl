use strict;
use warnings;
use utf8;

my $fileName = "/home/name/Documents/perl/url_list.txt";
my %hash = ();

sub file_content {
    my ($file) = @_;
    my $contents;
    open( my $fh, '<', $file ) or die "Cannot open torrent $file";
    while(my $line = <$fh>) {
        $hash{$line} = 1;
    }
    close($fh);
}

file_content($fileName);
open( my $fh, '>', $fileName ) or die "Cannot open torrent $fileName";

while(my $line = <STDIN>) {
    chomp($line);
    if($line eq "write") {        
        my @keys = keys %hash;
        foreach my $key (@keys) {
            print $fh $key;
            print $fh "\n";
        }
        close($fh);
    }
    elsif($hash{$line}) {
        print "name already exists\n";
    } else {
        $hash{$line} = 1;
    }
}


