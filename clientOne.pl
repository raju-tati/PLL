use strict;
use warnings;
use utf8;
use experimentals;
use IO::Socket qw(AF_INET SOCK_STREAM SHUT_WR);

$| = 1;

my $client = IO::Socket->new(
    Domain => AF_INET,
    Type => SOCK_STREAM,
    Proto => 'tcp',
    PeerPort => 8449,
    PeerHost => '0.0.0.0',
) or say "Cannot create socket: ", $IO::Socket::errstr;

say "Connected on 8447 port";
my $size = $client->send("Hello World!");
say "Sent data of length: ", $size;

my $buffer;
$client->recv($buffer, 1024);
say "Got back: ", $buffer;

$client->close();
