use strict;
use warnings;
use experimentals;
use threads;
use Time::HiRes;
use LWP::Simple qw(get);

sub fibonacci($num) {
    if ($num == 0) {
        return 1;
    } elsif($num == 1) {
        return 1;
    } else {
        return fibonacci($num -1) + fibonacci($num -2);
    }
}

sub fetchPages($urls) {
    foreach my $url (@{$urls}) {
        Time::HiRes::sleep(0.001);
        async {
            my $page = get($url);
            say $url, " downloaded";
        };
    }
}

sub main() {
    async { 
        say fibonacci(4);
        say fibonacci(34);
        say fibonacci(34);
        say fibonacci(34);

        if(threads->self()->is_running()) {
            say "thread is running";
            say "yield thread ", threads->self()->tid();
            threads->yield(); # give cpu to other threads
        }
        
        say fibonacci(34);
        say fibonacci(34);
        say fibonacci(34);
        say fibonacci(34);

        async {
            say "thread inside thread";
        };
    };

    async {
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
        say fibonacci(33);
    };

    async {
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
        say fibonacci(32);
    };

    async { 
        say fibonacci(2);
        say fibonacci(35);
        
        say "Exiting thread ", threads->self()->tid();  # get thread id
        threads->exit();    # terminate thread

        say fibonacci(35);
        say fibonacci(35);
        say fibonacci(35);
        say fibonacci(35);
        say fibonacci(35);
        
        say fibonacci(35);  
    };

    my @urls = qw( https://www.facebook.com
                   https://www.google.com
                   https://www.wikipedia.org
                   https://www.stackoverflow.com );

    fetchPages(\@urls);
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
