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
	[ Default => 'default' ],
	{ name => 'CatApp' },
	{ global_config_root => dir('corpus/mint')->absolute },
);

$tzil->mint_dist;

# mint root
my $mr   = dir( $tzil->tempdir )->subdir('mint');
my $mrl  = $mr->subdir('lib');
my $mrr  = $mr->subdir('root');
my $mrs  = $mr->subdir('script');
my $mrt  = $mr->subdir('t');
my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');

ok( -e $mr->file('catapp.conf'),      'catapp.conf exists');
ok( -e $mrl->file('CatApp.pm'), 'CatApp.pm exists');
ok( -e $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm'), 'controller exists');

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

# tests
ok(   -e $mrt->file('01app.t'), 'app test exists');
ok( ! -e $mrt->file('02pod.t'), '02pod.t does not exists');
ok( ! -e $mrt->file('03podcoverage.t'), 'pod coverage test does not exist');

SKIP: {
	skip 'skip failing executable tests on windows ', 8, if $^O eq 'MSWin32';
	# check that these are not executable ( small sampling of the above files
	# to make sure it's not over chmoding perms )
	ok(
		! -x $mrl->file('CatApp.pm')
		, 'CatApp.pm is not executable'
	);
	ok(
		! -x $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm')
		, 'controller is not executable'
	);
	ok(
		! -x $mr->file('catapp.conf')
		, 'catapp.conf is not executable'
	);
	# check these are executable
	ok(
		-x $mrs->file('catapp_cgi.pl'),
		'_cgi.pl is executable'
	);
	ok(
		-x $mrs->file('catapp_create.pl')
		, '_create.pl is executable'
	);
	ok(
		-x $mrs->file('catapp_fastcgi.pl'),
		'_fastcgi.pl is executable'
	);
	ok(
		-x $mrs->file('catapp_server.pl'),
		'_server.pl is executable'
	);
	ok(
		-x $mrs->file('catapp_server.pl'),
		'_server.pl is executable'
	);
}
done_testing;
