use strict;
use warnings;

package MetaPOD::Format::JSON::inherits;

# ABSTRACT: Implementation of JSON/inherits format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::inherits",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

use Carp qw(croak);

sub add_v1 {
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
