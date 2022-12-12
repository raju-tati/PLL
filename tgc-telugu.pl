use strict;
use warnings;
use utf8;

my @dheerga = ("ా", "ి", "ీ", "ు", "ూ", "ృ", "ౄ", "ె", "ే", "ై", "ొ", "ో", "ౌ", "ం", "ఁ", "ః", "ఀ");
my $visarga = "్";
my @consonant = ( "క", "ఖ", "గ", "ఘ", "ఙ", "చ", "ఛ", "జ", "ఝ", "ఞ", "ట", "ఠ",
                  "ణ", "త", "థ", "ధ", "ప", "ఫ", "బ", "భ", "మ", "య",
                  "డ", "ఢ", "ర", "ఱ", "ల", "ళ", "ఴ", "వ", "శ", "ష", "స", "హ" );
my $counter = 0;
my @tgc;
my @temp;

my $string = "రాజ్కుమార్ రెడ్డి";
my @array = split("", $string);

while($counter <= $#array) {
    my $element = $array[$counter];
    $counter++;

    if($element ~~ @consonant) {
        @temp = ();
        push @temp, $element;
        $element = $array[$counter];
        if($element ~~ @dheerga) {
            $counter++;
            push @temp, $element;
            push @tgc, join("", @temp);
            next;
        }
        if($element eq $visarga) {
            push @temp, $element;
            $counter++;
            while(1) {
                $element = $array[$counter];
                if($element ~~ @consonant) {
                    push @temp, $element;
                    $counter++;
                    $element = $array[$counter];
                    if($element ~~ @dheerga) {
                        push @temp, $element;
                        $counter++;
                        last;
                    }
                    if($element eq $visarga) {
                        push @temp, $element;
                        $counter++;
                        next;
                    }
                    last;
                }
                else {
                    last;
                }
            }
        }
        push @tgc, join("", @temp);
        next;
    }
    else {
        push @tgc, $element;
        next;
    }
}

use Data::Printer;
p @tgc;
