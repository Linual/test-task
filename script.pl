#!/usr/bin/perl
use POSIX;
use File::Find;
use Sys::Syslog;

my $date = POSIX::strftime ('%Y-%m-%d %H:%M:%S', localtime);
open (FHW, '>', $date);
openlog("script.pl");
syslog(LOG_WARNING, "A new file has been created: $date\n");
my $deletedir = "./";
my @file_list;
my @find_dir = ($deletedir);
my $ctime = time ();
my $age = 60;
syslog(LOG_WARNING, "Find and delete files older than 1 minute in the current directory\n");
find ( sub {
  my $file = $File::Find::name;
  if ( -f $file ) {
    push (@file_list, $file);
  }
}, @find_dir);
@file_list = grep {!/script.pl/} @file_list;
for my $file (@file_list) {
  my @stats = stat($file);
  if ($ctime-$stats[9] > $age) {
    syslog(LOG_WARNING, "$file\n");
    unlink $file;
  }
}
