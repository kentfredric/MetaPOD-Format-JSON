
use strict;
use warnings;

package MetaPOD::Result;

# ABSTRACT: Compiled aggregate result object for MetaPOD

=begin MetaPOD::JSON v1.0.0

{
    "namespace": "MetaPOD::Result",
    "inherits" : "Moo::Object",
}

=end MetaPOD::JSON

=cut

use Moo;
use List::AllUtils qw( uniq );

=method set_namespace

    $result->set_namespace( $namespace )

=cut


has namespace => (
  is       => ro            =>,
  required => 0,
  lazy     => 1,
  builder  => sub           { undef },
  writer   => set_namespace =>,
  reader   => namespace     =>,
);

has inherits => (
  is       => ro            =>,
  required => 0,
  lazy     => 1,
  builder  => sub           { [] },
  writer   => _set_inherits =>,
  reader   => _inherits     =>,
);

=method inherits

    my @inherits = $result->inherits;

=cut

sub inherits {
  my $self = shift;
  return @{ $self->_inherits };
}

=method set_inherits

    $result->set_inherits( @inherits )

=cut

sub set_inherits {
  my ( $self, @inherits ) = @_;
  $self->_set_inherits( [ uniq @inherits ] );
  return $self;
}

=method add_inherits

    $result->add_inherits( @inherits );

=cut

sub add_inherits {
  my ( $self, @items ) = @_;
  $self->_set_inherits( [ uniq @{ $self->_inherits }, @items ] );
  return $self;
}

1;
