#!/usr/bin/perl
use strict;
use warnings;
use Dist::Zilla::Tester;
use Test::More;
use Path::Class;
use boolean;

my $tzil = Minter->_new_from_profile(
	[ Default => 'default' ],
	{ name => 'CatApp', },
	{ global_config_root = dir('corpus/mint')->absolute },
);

$tzil->mint_dist;

my $mint_root = dir( $tzil->tempdir )->subdir('mint');

my $exists =  ( -e "$mint_root/CatApp.pm" )  ? true : false;

ok( $exists, true, 'CatApp.pm exists' );

done_testing;
