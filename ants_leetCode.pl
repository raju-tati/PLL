use strict;
use warnings;
use List::Util qw(min max);

sub move {
    my ($n, $left, $right) = @_;

    my $max = max @{$left};
    my $maxTimeForLeft = $max - 0;

    my $maxRight = min @{$right};
    my $maxTimeForRight = $n - $maxRight;

    return max ($maxTimeForLeft, $maxTimeForRight);
}

my $n = 28;
my $time = move($n, [12,13,15], [11,14,18]);
print $time;
