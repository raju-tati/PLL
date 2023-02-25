use strict;
use warnings;
use EV;
use AnyEvent;
use Coro;
use Coro::Handle;
use Coro::AnyEvent;
use AnyEvent::Socket;

tcp_connect 'localhost', 8888, Coro::rouse_cb;
my $fh = unblock +(Coro::rouse_wait)[0] or Coro::terminate;

local $/;
print <$fh>;
