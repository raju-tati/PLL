package Main;
use Basics;

sub main($this) {
    async {
        say "testing threads";
    };
}

1;

use Basics;
sub begin(){my $mainObject = Main->new();$mainObject->main();}
my $monitorThread = async { while(1) {
foreach my $thread (threads->list(threads::joinable)) {
$thread->detach(); } Time::HiRes::sleep(0.005); }};
begin();while(1) { my @threads = threads->list(threads::all);
if(scalar @threads == 1) { $monitorThread->detach();
last; } else { Time::HiRes::sleep(0.005); }}
