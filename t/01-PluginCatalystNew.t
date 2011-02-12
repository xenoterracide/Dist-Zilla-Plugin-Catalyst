#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

if ( $Moose::VERSION >= 1.9902 and $Moose::VERSION < 2.0 ) {
	plan skip_all => 'Module is broken on Devel Moose, don\'t test';
}

use Dist::Zilla::Tester;
use Path::Class;
use FindBin;
use lib "$FindBin::Bin/lib";
use DZPCshared qw( 'DZPCshared' );

my $tzil = Minter->_new_from_profile(
	[ Default => 'default' ],
	{ name => 'CatApp' },
	{ global_config_root => dir('corpus/mint')->absolute },
);

$tzil->mint_dist;

my $should_exists = _cat_files_exist( $tzil->name, $tzil->tempdir );

foreach ( @{$should_exists} ) {
	ok	( -e $_ , "$_" . 'exists' );
}

done_testing;
