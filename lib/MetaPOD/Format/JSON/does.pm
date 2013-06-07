use strict;
use warnings;

package MetaPOD::Format::JSON::does;

# ABSTRACT: Implementation of JSON/does format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::does",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

use Carp qw(croak);

=method add_v1

Spec V1 C<does> Implementation

    MetaPOD::Format::JSON::does->add_v1( $data->{does} , $metapod_result );

=cut

sub add_v1 {
  my ( $self, $does, $result ) = @_;
  if ( defined $does and not ref $does ) {
    return $result->add_does($does);
  }
  if ( defined $does and ref $does eq 'ARRAY' ) {
    return $result->add_does( @{$does} );
  }
  croak 'Unsupported reftype ' . ref $does;
}

1;
