package Dist::Zilla::Plugin::Catalyst::New;
use Moose;
with 'Dist::Zilla::Role::FileGatherer';

use Dist::Zilla::File::FromCode;
use Dist::Zilla::Plugin::Catalyst::Helper;

sub gather_files {
	my ( $self, $arg ) = @_;

	my $helper
		= Dist::Zilla::Plugin::Catalyst::Helper->new({
			name => $self->zilla->name,
			_zilla_gatherer => $self
		});
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;
