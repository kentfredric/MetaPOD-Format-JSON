
use strict;
use warnings;

package MetaPOD::Format::JSON::v1_1;

# ABSTRACT: MetaPOD::JSON v1 SPEC Implementation

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::v1_1",
    "interface":"single_class",
    "inherits" : "MetaPOD::Format::JSON::v1",
    "does":[
        "MetaPOD::Format::JSON::interface::v1_1"
    ]
}

=end MetaPOD::JSON

=cut

use Moo;

extends 'MetaPOD::Format::JSON::v1';
with 'MetaPOD::Format::JSON::interface::v1_1';

sub features {
  return qw( does inherits namespace interface );
}

1;
