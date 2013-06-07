
use strict;
use warnings;

package MetaPOD::Result;

# ABSTRACT: Compiled aggregate result object for MetaPOD

=begin MetaPOD::JSON v1.1.0

{
    "namespace": "MetaPOD::Result",
    "inherits" : "Moo::Object",
    "interface": "class"
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

has does => (
  is       => ro        =>,
  required => 0,
  lazy     => 1,
  builder  => sub       { [] },
  writer   => _set_does =>,
  reader   => _does     =>,
);

has interface => (
  is       => ro             =>,
  required => 0,
  lazy     => 1,
  builder  => sub            { [] },
  writer   => _set_interface =>,
  reader   => _interface     =>,
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

=method does

    my @does = $result->does;

=cut

sub does {
  my $self = shift;
  return @{ $self->_does };
}

=method set_does

    $result->set_does( @does )

=cut

sub set_does {
  my ( $self, @does ) = @_;
  $self->_set_does( [ uniq @does ] );
  return $self;
}

=method add_does

    $result->add_does( @does );

=cut

sub add_does {
  my ( $self, @items ) = @_;
  $self->_set_does( [ uniq @{ $self->_does }, @items ] );
  return $self;
}

=method interface

    my @interfaces = $result->interface;

=cut

sub interface {
  my $self = shift;
  return @{ $self->_interface };
}

=method set_interface

    $result->set_interface( @interfaces )

=cut

sub set_interface {
  my ( $self, @interfaces ) = @_;
  $self->_set_interface( [ uniq @interfaces ] );
  return $self;
}

=method add_interface

    $result->add_interface( @interface );

=cut

sub add_interface {
  my ( $self, @items ) = @_;
  $self->_set_interface( [ uniq @{ $self->_interface }, @items ] );
  return $self;
}

1;
