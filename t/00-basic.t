#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use Dist::Zilla::Tester;

my $tzil = Dist::Zilla::Tester->from_config({ dist_root => 'corpus/DZT' });

$tzil->build;

my $lib_0 = $tzil->slurp_file('build/libZZ
