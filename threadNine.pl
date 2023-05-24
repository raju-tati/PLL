use strict;use warnings;use utf8;use Time::HiRes;
use threads;use threads::shared;use Object::Pad;use experimentals;

class Main {
    use strict;use warnings;use utf8;use threads;
    use threads::shared;use experimentals;use Time::HiRes;

    field $upTime :param;

    method main() {
        async {
            say "upTime: ", $upTime;
            say "from thread: ", threads->self->tid();
        };
    }
}

sub begin(){my $mainObject=Main->new(upTime=>time());$mainObject->main();}
my $monitorThread = async { while(1) {
foreach my $thread (threads->list(threads::joinable)) {
$thread->detach(); } Time::HiRes::sleep(0.005); }};
begin();while(1) { my @threads = threads->list(threads::all);
if(scalar @threads == 1) { $monitorThread->detach();
last; } else { Time::HiRes::sleep(0.005); }}
