use strict;
use warnings;

package MetaPOD::Format::JSON::inherits::v1;

# ABSTRACT: Implementation of JSON/inherits format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::inherits::v1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;
use Carp qw(croak);

=method add_v1

Spec v1 C<inherits> Implementation

    MetaPOD::Format::JSON::inherits->add_v1( $data->{inherits} , $metapod_result );

=cut

sub add_inherits {
  my ( $self, $inherits, $result ) = @_;
  if ( defined $inherits and not ref $inherits ) {
    return $result->add_inherits($inherits);
  }
  if ( defined $inherits and ref $inherits eq 'ARRAY' ) {
    return $result->add_inherits( @{$inherits} );
  }
  croak 'Unsupported reftype ' . ref $inherits;
}

1;
