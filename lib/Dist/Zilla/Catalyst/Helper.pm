use strict;
use warnings;
package Dist::Zilla::Catalyst::Helper;
BEGIN {
	# VERSION
}
use Moose;
use Dist::Zilla::File::InMemory;
use Path::Class;

extends 'Catalyst::Helper';

has _zilla_gatherer => (
	is       => 'ro',
	required => 1,
	handles  => {
		_zilla_add_file => 'add_file',
	},
);

# we don't want these to do anything
sub _mk_changes {};
sub _mk_makefile {};
sub _mk_readme {};
sub _mk_apptest {};
sub _mk_podtest {};
sub _mk_podcoveragetest {};

sub mk_file {
	my ( $self, $file_obj , $output ) = @_;

	# unfortunately the stringified $file_obj includes a prepended
	# {dist_repo} name which dzil already creates if we don't regex it out we
	# end up with {dist_repo}/{dist_repo}/{files} instead of just
	# {dist_repo}/{files}
	my $cat_file = file( "$file_obj" );
	my $cat_dir  = $cat_file->dir;
	my @path     = $cat_dir->dir_list;
	shift @path;

	# ok so this isn't really just a name, but that's what we're using it for
	my $name = file( @path, $cat_file->basename );

	my $file
		= Dist::Zilla::File::InMemory->new({
			name    => $name->stringify,
			content => $output,
		});

	$file->mode( oct(755) ) if $file->name =~ /script/;

	$self->_zilla_add_file($file);
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;
# ABSTRACT: a subclass of Catalyst::Helper

=head1 DESCRIPTION

this is used to override methods in L<Catalyst::Helper> so that it works
better with dzil.

=cut
