
use strict;
use warnings;

package MetaPOD::Result;
BEGIN {
  $MetaPOD::Result::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Result::VERSION = '0.1.0';
}

# ABSTRACT: Compiled aggregate result object for MetaPOD


use Moo;
use List::AllUtils qw( uniq );



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
  return @{ $self->_inherits };
}


sub set_inherits {
  my ( $self, @inherits ) = @_;
  $self->_set_inherits( [ uniq @inherits ] );
  return $self;
}


sub add_inherits {
  my ( $self, @items ) = @_;
  $self->_set_inherits( [ uniq @{ $self->_inherits }, @items ] );
  return $self;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Result - Compiled aggregate result object for MetaPOD

=head1 VERSION

version 0.1.0

=head1 METHODS

=head2 set_namespace

    $result->set_namespace( $namespace )

=head2 inherits

    my @inherits = $result->inherits;

=head2 set_inherits

    $result->set_inherits( @inherits )

=head2 add_inherits

    $result->add_inherits( @inherits );

=begin MetaPOD::JSON v1.0.0

{
    "namespace": "MetaPOD::Result",
    "inherits" : "Moo::Object",
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
