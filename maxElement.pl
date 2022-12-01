use strict;
use warnings;

my @array = (1,6,14,7,8,4,9);

sub maxElement {
	my @array = @_;
	my $maxElement = shift(@array);

	foreach my $element (1 .. $#array) {
		if( $array[$element] >= $maxElement) {
			$maxElement = $array[$element];
		}
	}

	return $maxElement;
}

my $maxElement = maxElement(@array);
print($maxElement);


