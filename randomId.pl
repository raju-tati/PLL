use strict;
use warnings;
use Math::Int2Base qw(int2base);

my $randInt = time;
$randInt .= int rand(89) + 10 for 0 .. 5;
my $randomId = int2base($randInt, 62);

print $randomId;
