
use strict;
use warnings;

package MetaPOD::Exception::Decode::Data;

# ABSTRACT: Failures with decoding source data

use Moo;

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Exception::Decode::Data",
    "interface":"class",
    "inherits":"MetaPOD::Exception"
}

=end MetaPOD::JSON

=cut

extends 'MetaPOD::Exception';

=attr C<data>

The data that was being decoded when the exception occurred.

=cut

has 'data' => ( is => ro =>, required => 1, );

=attr C<internal_message>

Messages given from decoder

=cut

has 'internal_message' => ( is => ro =>, required => 1, );

has '+message' => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    return "While decoding:\n" . $_[0]->data . "\n Got: " . $_[0]->internal_message;
  },
);

1;
