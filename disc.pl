#!/usr/bin/perl
use strict;
use warnings;

use Filesys::DiskSpace;

my $space_limit = 10;	# if less then 10% send warning

if ($#ARGV == -1) {
    print "Usage is $0 <fs> [<fs>....]\n";
    exit (8);
}

# check each directory in list
foreach my $dir (@ARGV) {
    # Get the file system information
    my ($fs_type, $fs_desc, $used, 
        $avail, $fused, $favail) = df $dir;
    
    # The amount of free space
    my $per_free = (($avail) / ($avail+$used)) * 100.0;
    if ($per_free < $space_limit) {
	# work in progress
	my $msg = sprintf(
	  "WARNING: Free space on $dir ".
	      "has dropped to %0.2f%%", 
	  $per_free);
	system("wall '$msg'");
    }
}
