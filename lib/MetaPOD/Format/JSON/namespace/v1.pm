
use strict;
use warnings;

package MetaPOD::Format::JSON::namespace::v1;

# ABSTRACT: Implementation of JSON/namespace format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::namespace::v1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;

=method add_namespace

Spec V1 C<namespace> Implementation

    MetaPOD::Format::JSON::namespace->add_v1( $data->{namespace} , $metapod_result );

=cut

sub add_namespace {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

1;
