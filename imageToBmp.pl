use strict;
use warnings;
use utf8;
use Imager;

my $inputFile = "/path/to/image.jpg";
my $outputFile = "/path/to/image.bmp";

my $img = Imager->new();
$img->read(file => $inputFile);
my $reduced = $img->scale(xpixels => 600);
$reduced->write(file => $outputFile);
