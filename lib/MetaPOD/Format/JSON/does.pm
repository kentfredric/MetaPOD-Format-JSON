use strict;
use warnings;

package MetaPOD::Format::JSON::does;
BEGIN {
  $MetaPOD::Format::JSON::does::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::does::VERSION = '0.2.1';
}

# ABSTRACT: Implementation of JSON/does format component


use Carp qw(croak);

sub add_v1 {
  my ( $self, $does, $result ) = @_;
  if ( defined $does and not ref $does ) {
    return $result->add_does($does);
  }
  if ( defined $does and ref $does eq 'ARRAY' ) {
    return $result->add_does( @{$does} );
  }
  croak 'Unsupported reftype ' . ref $does;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::does - Implementation of JSON/does format component

=head1 VERSION

version 0.2.1

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::does",
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
