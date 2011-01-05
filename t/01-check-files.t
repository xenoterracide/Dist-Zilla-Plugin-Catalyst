#!/usr/bin/perl
use strict;
use warnings;
use Dist::Zilla::Tester;
use Test::More;
use Path::Class;

my $tzil = Minter->_new_from_profile(
	[ Default => 'default' ],
	{ name => 'CatApp', },
	{ global_config_root => dir('corpus/mint')->absolute },
);

$tzil->mint_dist;

# mint root
my $mr   = dir( $tzil->tempdir )->subdir('mint');
my $mrl  = $mr->subdir('lib');
my $mrs  = $mr->subdir('script');
my $mrr  = $mr->subdir('root');
my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');

ok(   -e $mr->file('catapp.conf'),      'catapp.conf exists');
ok(   -e $mrl->file('CatApp.pm'), 'CatApp.pm exists');
ok(   -e $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm'), 'controller exists');

# test scripts
ok( -e $mrs->file('catapp_cgi.pl'),     '_cgi.pl exists');
ok( -e $mrs->file('catapp_create.pl'),  '_create.pl exists');
ok( -e $mrs->file('catapp_fastcgi.pl'), '_fastcgi.pl exists');
ok( -e $mrs->file('catapp_server.pl'),  '_server.pl exists');
ok( -e $mrs->file('catapp_test.pl'),    '_test.pl exists');

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
		! -x $mrl->file('CatApp.pm')
		, 'CatApp.pm is executable'
	);
	ok(
		! -x $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm')
		, 'controller is executable'
	);
	ok(
		! -x $mr->file('catapp.conf')
		, 'catapp.conf is executable'
	);
	# check these are executable
	ok(
		-x $mrs->file('catapp_cgi.pl'),
		'_cgi.pl is not executable'
	);
	ok(
		-x $mrs->file('catapp_create.pl')
		, '_create.pl is not executable'
	);
	ok(
		-x $mrs->file('catapp_fastcgi.pl'),
		'_fastcgi.pl is not executable'
	);
	ok(
		-x $mrs->file('catapp_server.pl'),
		'_server.pl is not executable'
	);
	ok(
		-x $mrs->file('catapp_server.pl'),
		'_server.pl is no executable'
	);
}
done_testing;
