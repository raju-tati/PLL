use strict;
use warnings;
$| = 1;

sub show_face {
    my ($newFace, $dealay) = @_;
    print ("\r", $newFace, "\r");
    sleep($dealay);
}


while(1) {
    show_face("(-.-)", rand(1.5));
    show_face("(o.o)", rand(1.5));
}
