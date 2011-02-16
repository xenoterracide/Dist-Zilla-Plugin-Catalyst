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
	[ Catalyst => 'default' ],
	{ name => 'CatalystMinterProfile' },
	{ global_config_root => dir('corpus/minterprofile')->absolute },
);

$tzil->mint_dist;

my $dzpcs = DZPCshared->new({
	appname => $tzil->name,
	tempdir => $tzil->tempdir,
	mntroot => 'minterprofile',
});

subtest 'catalyst files that should exist' => sub {
	my $should_exists = [ @{$dzpcs->files}, @{$dzpcs->scripts} ];

	foreach ( @{$should_exists} ) {
		ok	( -e $_ , "$_" . ' exists' );
	}
};

subtest 'catalyst files that shouldn\'t exist' => sub {
	my $should_not_exist = [ @{ $dzpcs->files_not_created } ];
	foreach ( @{ $should_not_exist } ) {
		ok ( ! -e $_ , "$_" . ' does not exists' );
	}
};

subtest 'catalyst scripts that should be executable' => sub {
	plan({ skip_all => 'skip failing executable tests on windows' }) if $^O eq 'MSWin32';
	my $should_exec =  [ @{ $dzpcs->scripts } ];

	foreach ( @{ $should_exec } ) {
		ok	( -x $_ , "$_" . ' is executable' );
	}
};

subtest 'catalyst files that shoudln\'t be executable' => sub {
	my $shouldnt_exec = [ @{$dzpcs->files} ];

	foreach ( @{$shouldnt_exec} ) {
		ok	( ! -x $_ , "$_" . ' isn\'t executable' );
	}
};

done_testing;
