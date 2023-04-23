use strict;
use warnings;
use experimentals;
use threads;
use Redis;

my $redis = Redis->new();

sub main() {
    async {
        $redis->set("key" => "value");
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
}

main();
sleep 1;
$_->detach() for (threads->list());
