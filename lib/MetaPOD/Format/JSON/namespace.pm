
use strict;
use warnings;

package MetaPOD::Format::JSON::namespace;

# ABSTRACT: Implementation of JSON/namespace format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::namespace",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

sub add_v1 {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

1;
