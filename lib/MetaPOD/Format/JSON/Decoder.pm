use strict;
use warnings;

package MetaPOD::Format::JSON::Decoder;

# ABSTRACT: JSON<->Structure translation layer

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::Decoder",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

sub decoder_v1 {
  my ( $self, $data ) = @_;
  require JSON;
  return JSON->new->decode($data);
}

1;
