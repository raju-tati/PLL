use strict;
use warnings;
use experimentals;
use Thread qw(async);
use Thread::Queue;

my $queue = Thread::Queue->new();

async {
    $queue->enqueue(23);
    say "current size of queue: ", $queue->pending();
};

async {
    my $value = $queue->dequeue();
    say "value: ", $value;
    say "current size of queue: ", $queue->pending();
};

sleep 1;

$_->detach() for (threads->list());
