use strict;
use warnings;

package MetaPOD::Format::JSON::inherits;
BEGIN {
  $MetaPOD::Format::JSON::inherits::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::inherits::VERSION = '0.2.1';
}

# ABSTRACT: Implementation of JSON/inherits format component


use Carp qw(croak);


sub add_v1 {
  my ( $self, $inherits, $result ) = @_;
  if ( defined $inherits and not ref $inherits ) {
    return $result->add_inherits($inherits);
  }
  if ( defined $inherits and ref $inherits eq 'ARRAY' ) {
    return $result->add_inherits( @{$inherits} );
  }
  croak 'Unsupported reftype ' . ref $inherits;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::inherits - Implementation of JSON/inherits format component

=head1 VERSION

version 0.2.1

=head1 METHODS

=head2 add_v1

Spec v1 C<inherits> Implementation

    MetaPOD::Format::JSON::inherits->add_v1( $data->{inherits} , $metapod_result );

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::inherits",
    "interface":"single_class"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
