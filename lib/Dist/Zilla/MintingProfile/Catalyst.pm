package Dist::Zilla::MintingProfile::Catalyst;
use 5.008;
use strict;
use warnings;
BEGIN {
	our $VERSION = '0.16'; # VERSION
}
use Moose;
use namespace::autoclean;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Default Minting Profile


__END__
=pod

=head1 NAME

Dist::Zilla::MintingProfile::Catalyst - Default Minting Profile

=head1 VERSION

version 0.16

=head1 SYNOPSIS

on the command line

	dzil new -P Catalyst <ProjectName>

=head1 DESCRIPTION

This is a very basic Minting profile which when used will create a
L<Dist::Zilla::Plugin::DistINI> C<dist.ini> and the basic L<Catalyst::Helper>
files. If it doesn't create enough files for you, you should create a dzil
profile with the directions found in L<Dist::Zilla::Plugin::Catalyst::New>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/xenoterracide/Dist-Zilla-Plugin-Catalyst/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHORS

=over 4

=item *

Caleb Cushing <xenoterracide@gmail.com>

=item *

Tomas Doran <bobtfish@bobtfish.net>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

