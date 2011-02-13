use strict;
use warnings;
package DZPCshared;
use Path::Class;
use Moose;
use namespace::autoclean;

has 'appname' => (
	is       => 'ro',
	required => 1,
);

has 'tempdir' => (
	is       => 'ro',
	required => 1,
);

has 'directories' => (
	traits   => ['Array'],
	is       => 'ro',
	required => 1,
	lazy     => 1,
	default  => sub {
		my $self = shift;
		my $mr   = dir( $self->tempdir )->subdir('mint');
		my $mrl  = $mr->subdir('lib');
		my $mrr  = $mr->subdir('root');
		my $mrs  = $mr->subdir('script');
		my $mrt  = $mr->subdir('t');
		my $mrri = $mr->subdir('root')->subdir('static')->subdir('images');
		return my $directories = [
			$mr,
			$mrl,
			$mrr,
			$mrs,
			$mrt,
			$mrri,
		];
	},
);

has 'scripts' => (
	traits   => ['Array'],
	is       => 'ro',
	lazy     => 1,
	default  => sub {
		my $self = shift;
		my ( $mr, $mrl, $mrr, $mrs, $mrt, $mrri ) = @{ $self->directories };
		my $lc_app = lc $self->appname;
		return my $scripts = [
			$mrs->file  ( $lc_app . '_cgi.pl'     ),
			$mrs->file  ( $lc_app . '_create.pl'  ),
			$mrs->file  ( $lc_app . '_fastcgi.pl' ),
			$mrs->file  ( $lc_app . '_server.pl'  ),
			$mrs->file  ( $lc_app . '_test.pl'    ),
		];
	},
);

has 'files' => (
	traits   => ['Array'],
	is       => 'ro',
	lazy     => 1,
	default  => sub {
		my $self = shift;
		my ( $mr, $mrl, $mrr, $mrs, $mrt, $mrri ) = @{ $self->directories };
		my $lc_app = lc $self->appname;
		return my $files = [
			$mr->file   ( $lc_app . '.conf'               ),
			$mrl->file  ( $self->appname . '.pm'          ),
			$mrl->subdir( $self->appname )->subdir('Controller')->file('Root.pm'),
			$mrr->file  ( 'favicon.ico'                   ),
			$mrri->file ( 'btn_120x50_built.png'          ),
			$mrri->file ( 'btn_120x50_built_shadow.png'   ),
			$mrri->file ( 'btn_120x50_powered.png'        ),
			$mrri->file ( 'btn_120x50_powered_shadow.png' ),
			$mrri->file ( 'btn_88x31_built.png'           ),
			$mrri->file ( 'btn_88x31_built_shadow.png'    ),
			$mrri->file ( 'btn_88x31_powered.png'         ),
			$mrri->file ( 'btn_88x31_powered_shadow.png'  ),
			$mrri->file ( 'catalyst_logo.png'             ),
			$mrt->file  ( '01app.t'                       ),
		];
	},
);

__PACKAGE__->meta->make_immutable;
1;
