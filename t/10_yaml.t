#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

use Test::More tests => 2;

BEGIN { use_ok('YAML::Tiny'); }

my $sample=dirname($0) || ".";
$sample.="/../samples/wanfaild.yml";

SKIP: {
    skip "Sample configuration not found", 1 unless (-f $sample);

    ok(YAML::Tiny->new->read($sample), "Parse configuration sample");
};

# vi: set ai et:
