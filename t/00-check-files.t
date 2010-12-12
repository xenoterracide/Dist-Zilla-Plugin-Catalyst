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

is(   -e $mrl->file('CatApp.pm'), 'CatApp.pm exists');
isnt( -x $mrl->file('CatApp.pm'), 'CatApp.pm isnt executable');

is(   -e $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm'), 'controller exists');
isnt( -x $mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm'), 'controller isnt executable');

is(   -e $mr->file('catapp.conf'),      'catapp.conf exists');
isnt( -x $mr->file('catapp.conf'),      'catapp.conf isnt executable');

# test scripts
is( -e $mrs->file('catapp_cgi.pl'),     '_cgi.pl exists');
is( -x $mrs->file('catapp_cgi.pl'),     '_cgi.pl is executable');

is( -e $mrs->file('catapp_create.pl'),  '_create.pl exists');
is( -x $mrs->file('catapp_create.pl'),  '_create.pl is executable');

is( -e $mrs->file('catapp_fastcgi.pl'), '_fastcgi.pl exists');
is( -x $mrs->file('catapp_fastcgi.pl'), '_fastcgi.pl is executable');

is( -e $mrs->file('catapp_server.pl'),  '_server.pl exists');
is( -x $mrs->file('catapp_server.pl'),  '_server.pl is executable');

is( -e $mrs->file('catapp_test.pl'),    '_test.pl exists');
is( -x $mrs->file('catapp_server.pl'),  '_server.pl is executable');

# test root and images
is( -e $mrr->file('favicon.ico'),                    'favicon.ico exists');
is( -e $mrri->file('btn_120x50_built.png'),          'btn_120x50_built.png exists');
is( -e $mrri->file('btn_120x50_built_shadow.png'),   'btn_120x50_built_shadow.png exists');
is( -e $mrri->file('btn_120x50_powered.png'),        'btn_120x50_powered.png exists');
is( -e $mrri->file('btn_120x50_powered_shadow.png'), 'btn_120x50_powered_shadow.png exists');
is( -e $mrri->file('btn_88x31_built.png'),           'btn_88x31_built.png exists');
is( -e $mrri->file('btn_88x31_built_shadow.png'),    'btn_88x31_built_shadow.png exists');
is( -e $mrri->file('btn_88x31_powered.png'),         'btn_88x31_powered.png exists');
is( -e $mrri->file('btn_88x31_powered_shadow.png'),  'btn_88x31_powered_shadow.png');
is( -e $mrri->file('catalyst_logo.png'),             'catalyst_logo.png exists');

done_testing;
