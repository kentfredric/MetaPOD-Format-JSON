use strict;
use warnings;

package MetaPOD::Format::JSON::PostCheck;

# ABSTRACT: Handler for unrecognised tokens in C<JSON>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::PostCheck",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

use Carp qw( croak );

=method postcheck_v1

Spec V1 Handling of unprocessed keys

    MetaPOD::Format::JSON::PostCheck->postcheck_v1({ any_key_makes_it_go_bang => 1 }, $metapod_result );

=cut

sub postcheck_v1 {
  my ( $self, $data, $result ) = @_;

  if ( keys %{$data} ) {
    croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data} ) . '>';
  }
}

1;
