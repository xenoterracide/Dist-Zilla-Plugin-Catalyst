use strict;
use warnings;
package Dist::Zilla::MintingProfile::Catalyst;
BEGIN {
	# VERSION
}
use Moose;
use namespace::autoclean;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Default Minting Profile

=head1 SYNOPSIS

on the command line

	dzil new -P Catalyst <ProjectName>

=head1 DESCRIPTION

This is a very basic Minting profile which when used will create a
L<Dist::Zilla::Plugin::DistINI> C<dist.ini> and the basic L<Catalyst::Helper>
files. If it doesn't create enough files for you, you should create a dzil
profile with the directions found in L<Dist::Zilla::Plugin::Catalyst::New>.

=cut
