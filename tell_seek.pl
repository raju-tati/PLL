use feature qw(say);
use strict;
use warnings;

use Fcntl qw(SEEK_SET SEEK_CUR SEEK_END);

# filename;
my $fileName = '/home/.../Documents/perl/class.pl';
say "File Size: ", -s $fileName;

open my $fh, '<', $fileName or die "Cannot open file\n";
my $line;

say tell($fh);
$line = <$fh>;

print $line;
say tell($fh);

say '--- go to 0';
seek $fh, 0, SEEK_SET;
say tell($fh);

$line = <$fh>;
print($line);
say tell($fh);

say '-- go to 20';
seek $fh, 20, SEEK_SET;
say tell($fh);
$line = <$fh>;
print($line);
say tell($fh);

say '-- go back 14';
seek $fh, -14, SEEK_CUR;
say tell($fh);
$line = <$fh>;
print($line);
say tell($fh);

say '--go to the end';
seek $fh, 0, SEEK_END;
say tell($fh);
say eof($fh);

say '-- go 12 from end';
seek $fh, -12, SEEK_END;
say tell($fh);
$line = <$fh>;
print($line);
say tell($fh);
