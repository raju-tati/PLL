use strict;
use warnings;
use POSIX;
use EV;
use AnyEvent;
use Coro;
use Coro::Handle;
use Coro::AnyEvent;
use AnyEvent::Socket;

$| = 1;

print "Enter hostname: ";
chop(my $target = <stdin>);
print "Start port: ";
chop(my $startPort = <stdin>);
print "End port: ";
chop(my $endPort = <stdin>);

my @ports = ($startPort .. $endPort);
my $count = scalar @ports;

while($count) {
    async {
        my $port = shift(@ports);

        tcp_connect "$target", $port, Coro::rouse_cb;
        my $fh = unblock +(Coro::rouse_wait)[0] or terminate;

        print "$target - Port $port is open\n";        
    };
    $count = $count - 1;
}

cede;
EV::loop;
