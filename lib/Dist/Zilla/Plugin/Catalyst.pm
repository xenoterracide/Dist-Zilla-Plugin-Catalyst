package Dist::Zilla::Plugin::Catalyst;
use 5.006;
use strict;
use warnings;
BEGIN {
	our $VERSION = '0.16'; # VERSION
}
1;
# ABSTRACT: set of plugins for working with Catalyst


__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Catalyst - set of plugins for working with Catalyst

=head1 VERSION

version 0.16

=head1 SYNOPSIS

for quick start

	dzil new -P Catalyst <ProjectName>

=head1 DESCRIPTION

The following is a list of plugins in this distribution to help you integrate
L<Catalyst> and L<Dist::Zilla>

=over

=item * L<Dist::Zilla::Plugin::MinterProfile::Catalyst> Default Minting profile

=item * L<Dist::Zilla::Plugin::Catalyst::New> Create a new Catalyst Project

=back

=head1 PATCHES

Please read the SubmittingPatches file included with this Distribution. Patches
that are of sufficient quality, within the goals of the project and pass the
checklist will probably be accepted.

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

