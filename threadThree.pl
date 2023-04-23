use strict;
use warnings;
use experimentals;
use threads;
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
        async {
            my $page = get($url);
            say $url, " downloaded";
        };
    }
}

sub main() {
    async { 
        say fibonacci(4);
        say fibonacci(31);

        async {
            say "thread inside thread";
        };
    };

    async { 
        say fibonacci(2);
        say fibonacci(35);  
    };

    my @urls = qw( https://www.facebook.com
                   https://www.google.com
                   https://www.wikipedia.org
                   https://www.stackoverflow.com );

    fetchPages(\@urls);
}

main();
sleep 10;
$_->detach() for (threads->list());
