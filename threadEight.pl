use strict;
use warnings;
use experimentals;
use threads;
use threads::shared;
use Time::HiRes;

my %hash :shared;

sub main() {
    async {
        { lock(%hash); $hash{"key"} = 1; }
    };
    
    async {
        { lock(%hash); $hash{"key"}++; }
    };

    say "key is: ", $hash{"key"};
    Time::HiRes::sleep(0.001);
    say "key is: ", $hash{"key"};
}

my $signalThread = async {
    use sigtrap 'handler' => \&signalHandler, qw(INT);
};
sub signalHandler($signalName) {
    say "got an intterupt, print some info";
    my @threads = threads->list(threads::all);
    say "remaining threads: ", scalar @threads;
}
my $monitorThread = async {
    while(1) {
        foreach my $thread (threads->list(threads::joinable)) {
            $thread->detach();
        }
        Time::HiRes::sleep(0.005);
    }
};
main();
while(1) {
    my @threads = threads->list(threads::all);
    if(scalar @threads == 1) {
        $monitorThread->detach();
        last;
    } else {
        Time::HiRes::sleep(0.001);
    }
}
exit();
