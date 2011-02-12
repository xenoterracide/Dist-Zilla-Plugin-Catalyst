use strict;
use warnings;
package DZPCshared;
use Path::Class;
use parent 'Exporter';
our @EXPORT = ( '_cat_files_exist' );

sub _cat_files_exist {
	my ( $app_name, $tempdir ) = @_;

	# lowercase appname
	my $lc_app = lc $app_name;
# mint root
	my $mr   = dir( $tempdir )->subdir('mint');
	my $mrl  = $mr->subdir('lib');
	my $mrr  = $mr->subdir('root');
	my $mrs  = $mr->subdir('script');
	my $mrt  = $mr->subdir('t');
	my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');

# files
	my @cat_files = (
		$mr->file   ( $lc_app . 'conf'                ),
		$mrl->file  ( $app_name . '.pm'               ),
		$mrl->subdir( $app_name )->subdir('Controller')->file('Root.pm'),

# test scripts
		$mrs->file  ( $lc_app . '_cgi.pl'             ),
		$mrs->file  ( $lc_app . '_create.pl'          ),
		$mrs->file  ( $lc_app . '_fastcgi.pl'         ),
		$mrs->file  ( $lc_app . '_server.pl'          ),
		$mrs->file  ( $lc_app . '_test.pl'            ),
# test root and images
		$mrr->file  ( 'favicon.ico'                   ),
		$$mrri->file( 'btn_120x50_built.png'          ),
		$mrri->file ( 'btn_120x50_built_shadow.png'   ),
		$mrri->file ( 'btn_120x50_powered.png'        ),
		$mrri->file ( 'btn_120x50_powered_shadow.png' ),
		$mrri->file ( 'btn_88x31_built.png'           ),
		$mrri->file ( 'btn_88x31_built_shadow.png'    ),
		$mrri->file ( 'btn_88x31_powered.png'         ),
		$mrri->file ( 'btn_88x31_powered_shadow.png'  ),
		$mrri->file ( 'catalyst_logo.png'             ),
# tests
		$mrt->file  ( '01app.t'                       ),
		$mrt->file  ( '02pod.t'                       ),
		$mrt->file  ( '03podcoverage.t'               ),
	);
	return @cat_files;
}
1;
