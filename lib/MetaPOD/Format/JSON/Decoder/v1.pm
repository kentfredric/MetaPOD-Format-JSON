use strict;
use warnings;

package MetaPOD::Format::JSON::Decoder::v1;

# ABSTRACT: C<JSON> to Structure translation layer

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::Decoder::v1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;
use Try::Tiny qw( try catch );

=method C<decode>

Spec V1 C<JSON> Decoder

    my $hash = _SOME_CLASS_->decode( $json_string );

=cut

sub decode {
  my ( $self, $data ) = @_;
  require JSON;
  my $return;
  try {
    $return = JSON->new->decode($data);
  }
  catch {
    require MetaPOD::Exception::Decode::Data;
    MetaPOD::Exception::Decode::Data->throw(
      {
        internal_message   => $_,
        data               => $data,
        previous_exception => $_,
      }
    );
  };
  return $return;
}

1;
