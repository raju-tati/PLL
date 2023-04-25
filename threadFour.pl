use strict;
use warnings;
use experimentals;
use threads;
use Redis;

my $redis = Redis->new();

sub main() {
    async {
        $redis->set("key" => "value");
        $redis->set("key1" => "value1");
        $redis->set("key2" => "value2");
    };

    async {
        say $redis->get("key");
    };

    async {
        if( $redis->exists("key") ) {
            say "key exists on redis";
        }
    };

    async {
        if( $redis->exists("key") ) {
            $redis->del("key");
            say "key deleted";
        }
    };

    async {
        if( $redis->exists("key") ) {
            say "key still exists";
        } else {
            say "key doesnt exists";
        }
    };

    async {
        my @keys = $redis->keys("*");
        say join(", ", @keys);
    };

    async {
        my $randomKey = $redis->randomKey();
        say "randomKey ", $randomKey;
    };
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
