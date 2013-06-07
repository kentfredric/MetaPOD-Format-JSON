use strict;
use warnings;

package MetaPOD::Format::JSON::interface;

# ABSTRACT: Implementation of JSON/interface format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::interface",
    "interface":"single_class"
}

=end MetaPOD::JSON

=cut

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
