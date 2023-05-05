use strict;
use warnings;
use utf8;
use experimentals;
use threads;

$| = 1;

sub clientConnection($client) {
    async {
        my $clientAddress = $client->peerhost();
        my $clientPort = $client->peerport();
        say "Connection from $clientAddress: $clientPort";

        my $data = "";
        $client->recv($data, 1024);
        say "recieved data: ", $data, "\n";

        my $tid = "Thread id: " . threads->self->tid();
        $client->send($tid);
        $client->close();
    };
}

sub main() {
    async {
        use IO::Socket;
        my $server = IO::Socket->new(
            Domain => IO::Socket::AF_INET,
            Type => IO::Socket::SOCK_STREAM,
            Proto => 'tcp',
            LocalHost => '0.0.0.0',
            LocalPort => 8449,
            ReusePort => 1,
            Listen => 10,
        ) or say "cannot create socket";

        say "listening on 8449";

        while(1) {
            my $client = $server->accept();
            clientConnection($client);
        }

        $server->close();
    };
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
