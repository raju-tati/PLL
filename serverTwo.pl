use strict;
use warnings;
use utf8;
use experimentals;
use threads;

sub clientConnection($client, $newSocket) {
    async {
        my ($clientPort, $clientAddr) = unpack_sockaddr_in($client);
        my $tid = threads->self->tid();
        print $newSocket "a message from server $tid";
        print "Connection recieved from ", inet_ntoa($clientAddr),
                        ": ", $clientPort , "\n";
        close $newSocket;
    };
}

sub main() {
    async {
        use Socket;

        my $port = 8459;
        my $proto = getprotobyname('tcp');
        my $server = "localhost";

        socket(SOCKET, AF_INET, SOCK_STREAM, $proto) 
                    or say "cannot open socket $!";
        setsockopt(SOCKET, SOL_SOCKET, SO_REUSEADDR, 1) 
                    or say "cannot set socket option to SO_REUSEADDR $!";

        bind(SOCKET, pack_sockaddr_in($port, inet_aton($server)))
                    or say "Cannot bind to port ", $port;
        
        listen(SOCKET, 5) or say "listen Error: $!";
        say "Server started on port ", $port;

        my $newSocket;
        while(my $client = accept($newSocket, SOCKET)) {
            clientConnection($client, $newSocket);
        }
    };
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
        sleep(1);
    }
};

main();

while(1) {
    my @threads = threads->list(threads::all);
    if(scalar @threads == 1) {
        $monitorThread->detach();
        last;
    } else {
        sleep(1);
    }
}

exit();
