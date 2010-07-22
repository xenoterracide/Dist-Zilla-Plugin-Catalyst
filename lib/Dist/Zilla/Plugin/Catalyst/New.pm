use strict;
use warnings;
package Dist::Zilla::Plugin::Catalyst::New;
use Moose;
use Dist::Zilla::Plugin::Catalyst::Helper;
with qw( Dist::Zilla::Role::ModuleMaker );

use Dist::Zilla::File::FromCode;

sub make_module {
	my ( $self ) = @_;

	my $name = $self->zilla->name;
	$name =~ s/-/::/g;

	# turn authors into a scalar it's what C::Helper wants
	my $authors = join( ',', @{$self->zilla->authors} );

	my $helper
		= Dist::Zilla::Plugin::Catalyst::Helper->new({
			name            => $name,
			author          => $authors,
			_zilla_gatherer => $self,
		});
	$helper->mk_app( $name );
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;
# ABSTRACT: create a new catalyst project with dzil new

=head1 SYNOPSIS

in C<{home}/.dzil/profiles/{profile}/profile.ini>

	[Catalyst::New / :DefaultModuleMaker]

=head1 DESCRIPTION

this plugin is used to generate the same files L<Catalyst::Helper> does when
C<catalyst.pl App::Name> is run.

=head1 EXAMPLE

You probably want more than just the bare minimum profile.ini, here's a more
functional one. I suggest putting it in
C<{home}/.dzil/profiles/catalyst/profile.ini>

	[DistINI]
	[Catalyst::New / :DefaultModuleMaker]
	[Git::Init]

Now you can run the following command to create a skeleton catalyst app.

	dzil new -p catalyst MyApp

Obviously C<MyApp> is arbitrary and can be named whatever you like.

=head1 METHODS

=over

=item * make_module

required see L<Dist::Zilla::Role::ModuleMaker>

=back

=head1 BUGS

or features depending on your opinion and the nature of the issue. The
following are known "issue's".

=over

=item * Doesn't create all the files catalyst.pl does

Some files like README, Makefile.PL and some of the tests, etc, are better
generated by C<dzil>. Use existing dzil plugins to generate these.

=item * files aren't created with the author credentials in config.ini (etc)

This is more of a limitation of L<Catalyst::Helper> it gets the author name
from either the C<AUTHOR> environment variable or your system username. Use
those for now.

=back

For all other problems use the bug tracker

=cut
