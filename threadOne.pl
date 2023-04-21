use strict;
use warnings;
use Thread qw(yield async);

my $num = 0;
my @threads;

for (0 .. 4) {
    my $thread = async {
        foreach (0 .. 100000) {
            $num++;
        }
        print $num, "\n";
    };

    push @threads, $thread;
}

sleep 1;

foreach my $thread (@threads) {
    $thread->detach();
}
