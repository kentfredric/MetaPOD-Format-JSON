use strict;
use warnings;

package MetaPOD::Format::JSON::PostCheck;

# ABSTRACT: Handler for unrecognised tokens in JSON

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::PostCheck",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

use Carp qw( croak );

sub postcheck_v1 {
  my ( $self, $data, $result ) = @_;

  if ( keys %{$data} ) {
    croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data} ) . '>';
  }
}

1;
