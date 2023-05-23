package Main;
use Needs;

sub main($class) {
    async {
        if( threads->self->tid() == 2 ) {
           say "testing threads";
        } else {}
    };
}

1;

################################################################
use Needs; 
sub begin() {my $mainObject = Main->new(); $mainObject->main();}
my $monitorThread = async { while(1) {
foreach my $thread (threads->list(threads::joinable)) {
$thread->detach(); } Time::HiRes::sleep(0.005); }};
begin();while(1) { my @threads = threads->list(threads::all);
if(scalar @threads == 1) { $monitorThread->detach();
last; } else { Time::HiRes::sleep(0.005); }}
