use strict;
use warnings;

package MetaPOD::Format::JSON::does::v1;

# ABSTRACT: Implementation of JSON/does format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::does::v1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;
use Carp qw(croak);

=method add_does

Spec V1 C<does> Implementation

    __SOME_CLASS__->add_does( $data->{does} , $metapod_result );

=cut

sub add_does {
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
