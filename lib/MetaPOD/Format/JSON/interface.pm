use strict;
use warnings;

package MetaPOD::Format::JSON::interface;
BEGIN {
  $MetaPOD::Format::JSON::interface::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::interface::VERSION = '0.2.1';
}

# ABSTRACT: Implementation of JSON/interface format component


use Carp qw(croak);

sub supported_interfaces_v1_1 {
  return qw( class role type_library exporter single_class function );
}

sub check_interface_v1_1 {
  my ( $self, @ifs ) = @_;
  my $supported = { map { $_, 1 } $self->supported_interfaces_v1_1 };
  for my $if (@ifs) {
    if ( not exists $supported->{$if} ) {
      croak("interface type $if unsupported in v1.1.0");
    }
  }
  return $self;
}

sub add_v1_1 {
  my ( $self, $interface, $result ) = @_;
  if ( defined $interface and not ref $interface ) {
    return $result->add_interface($interface);
  }
  if ( defined $interface and ref $interface eq 'ARRAY' ) {
    return $result->add_interface( @{$interface} );
  }
  croak 'Unsupported reftype ' . ref $interface;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::interface - Implementation of JSON/interface format component

=head1 VERSION

version 0.2.1

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::interface",
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
