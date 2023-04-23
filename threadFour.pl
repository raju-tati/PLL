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
}

main();
sleep 1;
$_->detach() for (threads->list());
