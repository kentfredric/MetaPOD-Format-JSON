use strict;
use warnings;

package MetaPOD::Format::JSON::Decoder;

# ABSTRACT: C<JSON> to Structure translation layer

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::Decoder",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

=method decoder_v1

Spec V1 C<JSON> Decoder

    my $hash = MetaPOD::Format::JSON::Decoder->decoder_v1( $json_string );

=cut

sub decoder_v1 {
  my ( $self, $data ) = @_;
  require JSON;
  return JSON->new->decode($data);
}

1;
