use strict;
use warnings;
use utf8;
use Imager;

my $inputFile = "/path/to/image.jpg";
my $outputFile = "/path/to/image.bmp";

my $img = Imager->new();
$img->read(file => $inputFile);
my $bmp = $img->scale(ypixels => 600);
my $thumb = $bmp->scale(scalefactor=>.2);

$thumb->write(file => $outputFile);
