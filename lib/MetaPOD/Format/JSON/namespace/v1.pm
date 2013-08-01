
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

=method C<add_namespace>

Spec V1 C<namespace> Implementation

    $impl->add_namespace( $data->{namespace} , $metapod_result );

=cut

sub add_namespace {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

1;
