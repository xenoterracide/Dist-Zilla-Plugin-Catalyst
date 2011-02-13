#!/usr/bin/perl
use strict;
use warnings;
use Dist::Zilla::Tester;
use Test::More;
use Path::Class;

if ( $Moose::VERSION >= 1.9902 and $Moose::VERSION < 2.0 ) {
	plan skip_all => 'Module is broken on Devel Moose, don\'t test';
}

my $tzil = Minter->_new_from_profile(
	[ Catalyst => 'default' ],
	{ name => 'CatalystMinterProfile' },
	{ global_config_root => dir('corpus/minterprofile')->absolute },
);

$tzil->mint_dist;

my $dzpcs = DZPCshared->new({
	appname => $tzil->name,
	tempdir => $tzil->tempdir,
});

subtest 'catalyst files exist' => sub {
	my $should_exists = [ @{$dzpcs->files}, @{$dzpcs->scripts} ];

	foreach ( @{$should_exists} ) {
		ok	( -e $_ , "$_" . ' exists' );
	}
};

subtest 'catalyst scripts should be executable' => sub {
	plan({ skip_all => 'skip failing executable tests on windows' }) if $^O eq 'MSWin32';
	my $should_exec =  [ @{ $dzpcs->scripts } ];

	foreach ( @{ $should_exec } ) {
		ok	( -x $_ , "$_" . ' exists' );
	}
};
done_testing;
