
use strict;
use warnings;

package MetaPOD::Format::JSON::v1;

# ABSTRACT: MetaPOD::JSON v1 SPEC Implementation

use Moo;

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::v1",
    "interface":"single_class",
    "inherits":"Moo::Object",
    "does":[
        "MetaPOD::Format::JSON::Decoder::v1",
        "MetaPOD::Format::JSON::PostCheck::v1",
        "MetaPOD::Format::JSON::does::v1",
        "MetaPOD::Format::JSON::inherits::v1",
        "MetaPOD::Format::JSON::namespace::v1"
    ]
}

=end MetaPOD::JSON

=cut

with 'MetaPOD::Format::JSON::Decoder::v1',
  'MetaPOD::Format::JSON::PostCheck::v1',
  'MetaPOD::Format::JSON::does::v1',
  'MetaPOD::Format::JSON::inherits::v1',
  'MetaPOD::Format::JSON::namespace::v1';

sub features {
  return qw( does inherits namespace );
}

sub dispatch_keys {
  my ( $self, $data_decoded, $result ) = @_;
  for my $feature ( $self->features ) {
    my $method = 'add_' . $feature;
    next unless exists $data_decoded->{$feature};
    my $copy = delete $data_decoded->{$feature};
    $self->$method( $copy, $result );
  }
  return $self;
}

sub add_segment {
  my ( $self, $segment, $result ) = @_;
  my $data = $self->decode( $segment->{data} );
  $self->dispatch_keys( $data, $result );
  $self->postcheck($data);
}

1;
