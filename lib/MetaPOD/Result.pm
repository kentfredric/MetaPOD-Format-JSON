
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

sub inherits {
  my $self = shift;
  return @{ $self->inherits };
}

sub set_inherits {
  my ( $self, @inherits ) = @_;
  $self->_set_inherits( \@inherits );
}

sub add_inherits {
  my ( $self, @items ) = @_;
  push $self->inherits, @items;
}

