use strict;
use warnings;
use Socket;

my $proto = getprotobyname('tcp');
my ($sock);

socket($sock, AF_INET, SOCK_STREAM, $proto)
	or die "Could not create socket: $!";

my $remote = "google.com";
my $port = 80;

my $iaddr = inet_aton($remote)
	or die "Unable to resolve hostname: $remote";

my $paddr = sockaddr_in($port, $iaddr);

connect($sock, $paddr)
	or die "Connct failed: $!";

print "Connected to $remote on port $port\n";

send($sock, "GET / HTTP/1.1\r\n\r\n", 0)
	or die "Send failed: $!";

while(my $line = <$sock>) {
	print $line;
}

close($sock);
exit(0);
