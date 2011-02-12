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
use DZPCshared;

my $tzil = Minter->_new_from_profile(
	[ Default => 'default' ],
	{ name => 'CatApp' },
	{ global_config_root => dir('corpus/mint')->absolute },
);

$tzil->mint_dist;

my $should_exists = _cat_files_exist( $tzil->name, $tzil->tempdir );
my $should_exec   = _cat_files_exec ( $tzil->name, $tzil->tempdir );

foreach ( @{$should_exists} ) {
	ok	( -e $_ , "$_" . ' exists' );
}

SKIP: {
	skip 'skip failing executable tests on windows ', 8, if $^O eq 'MSWin32';
	my $should_exec = _cat_files_exec ( $tzil->name, $tzil->tempdir );

	foreach ( @{$should_exec} ) {
		ok	( -x $_ , "$_" . ' exists' );
	}
}

done_testing;
