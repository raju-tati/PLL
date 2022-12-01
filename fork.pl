
defined(my $pid = fork()) or die "Cannot fork: $!";

if ($pid == 0) {
    use strict;
    use warnings;
    use EV;
    use Coro;
    use AnyEvent;
    use Coro::AnyEvent;
    use Redis;

    my $redis = Redis->new;
    async {
        Coro::AnyEvent::sleep 2;
        my $key = $redis->get('key');
        print "key is ", $key, "\n";
        print "in a process 1 \n";
        Coro::AnyEvent::sleep 2;
    }

    cede;
    print "another process here from ", $$, "\n";
    EV::loop();
    exit;
}


use strict;
use warnings;
use EV;
use Coro;
use AnyEvent;
use Coro::AnyEvent;
use Redis;

my $redis = Redis->new;
async {
    $redis->set('key' => 'value');
    #$redis->get('key');
    print "in a main process \n";
    Coro::AnyEvent::sleep 2;
}

cede;
print "Main process here from ", $$, "\n";
EV::loop();
