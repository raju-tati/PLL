use strict;
use warnings;
use IO::Socket;

$| = 1;

print "Enter hostname: ";
chop(my $target = <stdin>);
print "Start port: ";
chop(my $startPort = <stdin>);
print "End port: ";
chop(my $endPort = <stdin>);

foreach (my $port = $startPort; $port <= $endPort; $port++) {
	print "Scanning port $port";
	my $socket = IO::Socket::INET->new(
		PeerAddr => $target,
		PeerPort => $port,
		Proto => 'tcp',
		Timeout => 1
	);

	if($socket) {
		print " Port $port is open.\n";
	} else {
		print " Port $port is closed. \n";
	}
}

print "Finished scanning $target\n";
exit(0);
