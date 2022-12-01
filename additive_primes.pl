use strict;
use warnings;

sub is_prime {
    my ($number) = @_;

    if($number < 1) { return 0; }

    foreach (2 .. sqrt($number)) {
        if( $number % $_ == 0 ) {
            return 0;
        }
    }

    return 1;
}

sub numerals_sum {
    my ($number) = @_;

    my @numerals = split("", $number);
    my $sum;

    foreach my $numeral (@numerals) {
        $sum += $numeral;
    }

    return $sum;
}

sub additive_prime {
    my ($number) = @_;

    if(is_prime($number)) {
        my $sum = numerals_sum($number);
        if(is_prime($sum)) {
            return 1;
        }
        else {
            return 0;
        }
    }
}

my $bool = additive_prime(23);
print "additive_prime \n" if($bool);
