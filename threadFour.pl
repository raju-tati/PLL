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

main();

while(1) {
    foreach my $thread (threads->list(threads::joinable)) {
        $thread->detach();
    }

    my @threads = threads->list(threads::all);
    if(scalar @threads == 0) {
        last;
    }

    Time::HiRes::sleep(0.25);
}
