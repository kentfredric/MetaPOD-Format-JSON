use strict;
use warnings;

package MetaPOD::Exception;

use Moo;

# ABSTRACT: Base class for C<MetaPOD> exceptions.

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Exception",
    "interface":"class",
    "inherits":"Throwable::Error"
}

=end MetaPOD::JSON

=cut

extends 'Throwable::Error';

no Moo;

1;
