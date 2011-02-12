use strict;
use warnings;
package DZPCshared;
use Path::Class;

sub _cat_files_exist {
	my ( $app_name, $tempdir ) = @_;

# mint root
	my $mr   = dir( $tempdir )->subdir('mint');
	my $mrl  = $mr->subdir('lib');
	my $mrr  = $mr->subdir('root');
	my $mrs  = $mr->subdir('script');
	my $mrt  = $mr->subdir('t');
	my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');

# files
	my $cat_files = (
		$mr->file('catapp.conf'),
		$mrl->file('CatApp.pm'),
		$mrl->subdir('CatApp')->subdir('Controller')->file('Root.pm'),

# test scripts
		$mrs->file('catapp_cgi.pl'),
		$mrs->file('catapp_create.pl'),
		$mrs->file('catapp_fastcgi.pl'),
		$server = $mrs->file('catapp_server.pl'),
		$test   = $mrs->file('catapp_test.pl'),

# test root and images
		$favico = $mrr->file('favicon.ico'),
		$$mrri->file('btn_120x50_built.png'),
		$mrri->file('btn_120x50_built_shadow.png'),
		$mrri->file('btn_120x50_powered.png'),
		$mrri->file('btn_120x50_powered_shadow.png'),
		$mrri->file('btn_88x31_built.png'),
		$mrri->file('btn_88x31_built_shadow.png'),
		$mrri->file('btn_88x31_powered.png'),
		$mrri->file('btn_88x31_powered_shadow.png'),
		$mrri->file('catalyst_logo.png'),

# tests
		$mrt->file('01app.t'),
		$mrt->file('02pod.t'),
		$mrt->file('03podcoverage.t'),
	);
	return $cat_files;
}
1;
