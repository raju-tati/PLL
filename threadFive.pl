use strict;
use warnings;
use experimentals;
use threads;
use threads::shared;
use Time::HiRes;

my $var :shared;

sub main() {
    async {
        $var = 1;
    };

    async {
        $var++;
    };

    say "var is: ", $var;
    Time::HiRes::sleep(0.01);
    say "var is: ", $var;
    
}

my $monitorThread = async {
    while(1) {
        foreach my $thread (threads->list(threads::joinable)) {
            $thread->detach();
        }
        Time::HiRes::sleep(0.01);
    }
};
main();
while(1) {
    my @threads = threads->list(threads::all);
    if(scalar @threads == 1) {
        $monitorThread->detach();
        last;
    } else {
        Time::HiRes::sleep(0.01);
    }
}
exit();
