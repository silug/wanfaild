#!/usr/bin/perl

use strict;
use warnings;
use English qw( -no_match_vars );

use Test::More tests => 1;

SKIP: {
    skip "Must be run as root.", "1" unless ($EUID == 0);

    my $name="ethtool";

    my $dev=shift || "eth0";

    my @ethtool=`/sbin/ethtool $dev`;

    print @ethtool if ($ENV{'DEBUG'});

    my $status=(grep /^\s*Link\s+detected\s*:/, @ethtool)[0];

    if (defined($status) and $status =~ /:\s*(\S+)/) {
        print "$1\n" if ($ENV{'VERBOSE'});
        pass($name);
    } else {
        fail($name);
    }

};

# vi: set ai et:
