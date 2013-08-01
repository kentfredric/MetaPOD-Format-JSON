use strict;
use warnings;

package MetaPOD::Format::JSON::PostCheck::v1;

# ABSTRACT: Handler for unrecognised tokens in C<JSON>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::PostCheck::v1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;
use Carp qw( croak );

=method postcheck

Spec V1 Handling of unprocessed keys

    __SOME_CLASS__->postcheck({ any_key_makes_it_go_bang => 1 }, $metapod_result );

=cut

sub postcheck {
  my ( $self, $data, $result ) = @_;

  if ( keys %{$data} ) {
    croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data} ) . '>';
  }
}

1;
