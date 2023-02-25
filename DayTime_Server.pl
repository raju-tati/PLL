use strict;
use warnings;
use EV;
use AnyEvent;
use AnyEvent::Socket;

sub dayTime {
   use DateTime;
   my $dt = DateTime->now;
   $dt->set_time_zone('Asia/Kolkata');
        
   my $year = $dt->year;
   my $day = $dt->day;
   my $month_abbr = $dt->month_abbr;
   my $day_abbr = $dt->day_abbr;
   my $hms = $dt->hms;

   my $time = "$hms $day_abbr-$day-$month_abbr $year";  
}

tcp_server undef, 8888, sub {
   my ($fh, $host, $port) = @_;
   my $time = dayTime(); 
   syswrite $fh, "$time\015\012";
};

EV::loop();
