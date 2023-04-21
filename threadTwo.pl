use strict;
use warnings;
use Thread qw(yield async);
use Thread::Queue;

my $queue = Thread::Queue->new();

my $thread = async {
    $queue->enqueue(23);
    print "current size of queue: ", $queue->pending(), "\n";
};

my $anotherThread = async {
    my $value = $queue->dequeue();
    print "value: ", $value, "\n";
    print "current size of queue: ", $queue->pending(), "\n";
};

sleep 1;

$thread->detach();
$anotherThread->detach();
