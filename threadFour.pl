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
sleep 2;
$_->detach() for (threads->list());
