use strict;
use warnings;
package Dist::Zilla::Plugin::Catalyst::Helper;
use Moose;
use Dist::Zilla::File::InMemory;

extends 'Catalyst::Helper';

has _zilla_gatherer => (
	is => 'ro',
	required => 1,
	handles => {
		_zilla_add_file => 'add_file',
	},
);

# we don't want these to do anything
sub _mk_dirs {};
sub _mk_makefile{};

sub mk_file {
	my ( $path, $output ) = @_;
	my $file
		= Dist::Zilla::File::InMemory->new({
			name => $path,
			content => $output,
		});

	$self->_zilla_add_file($file);
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;
