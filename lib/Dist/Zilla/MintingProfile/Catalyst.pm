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
