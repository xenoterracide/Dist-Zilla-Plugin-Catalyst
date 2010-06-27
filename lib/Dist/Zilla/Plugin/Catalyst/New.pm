package Dist::Zilla::Plugin::Catalyst::New;
use Moose;
use Dist::Zilla::Plugin::Catalyst::Helper;
with qw( Dist::Zilla::Role::ModuleMaker );

use Dist::Zilla::File::FromCode;

sub make_module {
	my ( $self, $arg ) = @_;

	my $name = $self->zilla->name;
	$name =~ s/-/::/g;

	my $helper
		= Dist::Zilla::Plugin::Catalyst::Helper->new({
# this is how we should do it but it does nothing... probably upstream bug
#			name            => $name,
			_zilla_gatherer => $self,
		});
	$helper->mk_app( $name );
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;
