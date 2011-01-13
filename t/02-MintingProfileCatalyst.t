#!/usr/bin/perl
use strict;
use warnings;
use Dist::Zilla::Tester;
use Test::More;
use Path::Class;

my $tzil = Minter->_new_from_profile(
	[ Catalyst => 'default' ],
	{ name => 'CatalystMinterProfile' },
	{ global_config_root => dir('corpus/minterprofile')->absolute },
);

$tzil->mint_dist;

# mint root
my $mr   = dir( $tzil->tempdir )->subdir('mint');
my $mrl  = $mr->subdir('lib');
my $mrs  = $mr->subdir('script');
my $mrr  = $mr->subdir('root');
my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');

ok( -e $mr->file('catalystminterprofile.conf'), 'catalystminterprofile.conf exists');
ok( -e $mrl->file('CatalystMinterProfile.pm'), 'CatalystMinterProfile.pm exists');
ok( -e $mrl->subdir('CatalystMinterProfile')->subdir('Controller')->file('Root.pm'), 'controller exists');

# test scripts
ok( -e $mrs->file('catalystminterprofile_cgi.pl'),     '_cgi.pl exists');
ok( -e $mrs->file('catalystminterprofile_create.pl'),  '_create.pl exists');
ok( -e $mrs->file('catalystminterprofile_fastcgi.pl'), '_fastcgi.pl exists');
ok( -e $mrs->file('catalystminterprofile_server.pl'),  '_server.pl exists');
ok( -e $mrs->file('catalystminterprofile_test.pl'),    '_test.pl exists');

# test root and images
ok( -e $mrr->file('favicon.ico'),                    'favicon.ico exists');
ok( -e $mrri->file('btn_120x50_built.png'),          'btn_120x50_built.png exists');
ok( -e $mrri->file('btn_120x50_built_shadow.png'),   'btn_120x50_built_shadow.png exists');
ok( -e $mrri->file('btn_120x50_powered.png'),        'btn_120x50_powered.png exists');
ok( -e $mrri->file('btn_120x50_powered_shadow.png'), 'btn_120x50_powered_shadow.png exists');
ok( -e $mrri->file('btn_88x31_built.png'),           'btn_88x31_built.png exists');
ok( -e $mrri->file('btn_88x31_built_shadow.png'),    'btn_88x31_built_shadow.png exists');
ok( -e $mrri->file('btn_88x31_powered.png'),         'btn_88x31_powered.png exists');
ok( -e $mrri->file('btn_88x31_powered_shadow.png'),  'btn_88x31_powered_shadow.png');
ok( -e $mrri->file('catalyst_logo.png'),             'catalyst_logo.png exists');

SKIP: {
	skip 'skip failing executable tests on windows ', 8, if $^O eq 'MSWin32';
	# check that these are not executable ( small sampling of the above files
	# to make sure it's not over chmoding perms )
	ok(
		! -x $mrl->file('catalystminterprofile.pm')
		, 'catalystminterprofile.pm is not executable'
	);
	ok(
		! -x $mrl->subdir('catalystminterprofile')->subdir('Controller')->file('Root.pm')
		, 'controller is not executable'
	);
	ok(
		! -x $mr->file('catalystminterprofile.conf')
		, 'catalystminterprofile.conf is not executable'
	);
	# check these are executable
	ok(
		-x $mrs->file('catalystminterprofile_cgi.pl'),
		'_cgi.pl is executable'
	);
	ok(
		-x $mrs->file('catalystminterprofile_create.pl')
		, '_create.pl is executable'
	);
	ok(
		-x $mrs->file('catalystminterprofile_fastcgi.pl'),
		'_fastcgi.pl is executable'
	);
	ok(
		-x $mrs->file('catalystminterprofile_server.pl'),
		'_server.pl is executable'
	);
	ok(
		-x $mrs->file('catalystminterprofile_server.pl'),
		'_server.pl is executable'
	);
}
done_testing;
