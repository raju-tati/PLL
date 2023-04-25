use strict;
use warnings;
use experimentals;
use threads;
use Redis;
use Time::HiRes;

my $redis = Redis->new();

sub main() {
    async {
        my $redis = Redis->new();
        $redis->set("key" => 1);
    };

    async {
        my $redis = Redis->new();
        my $key = $redis->get("key");
        $key++;
        $redis->set("key" => $key);
    };

    say "key is: ", $redis->get("key");
    Time::HiRes::sleep(0.01);
    say "key is: ", $redis->get("key");
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
        Time::HiRes::sleep(0.01);
    }
}
exit();
