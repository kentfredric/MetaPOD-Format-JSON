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

=method supported_interfaces_v1_1

Spec v1.1 C<interface> value list.

    my @valid_interface_tokens = MetaPOD::Format::JSON::interface->supported_interfaces_v1_1

=cut

sub supported_interfaces_v1_1 {
  return qw( class role type_library exporter single_class function );
}

=method check_interface_v1_1

Spec v1.1 C<interface> Implementation key checking routine

    MetaPOD::Format::JSON::interface->check_interface_v1_1( $interface, $interface, $interface );

Simply goes C<bang> if C<$interface> is not in C<supported_interfaces_v1_1>

=cut

sub check_interface_v1_1 {
  my ( $self, @ifs ) = @_;
  my $supported = { map { ( $_, 1 ) } $self->supported_interfaces_v1_1 };
  for my $if (@ifs) {
    if ( not exists $supported->{$if} ) {
      croak("interface type $if unsupported in v1.1.0");
    }
  }
  return $self;
}

=method add_v1_1

Spec v1.1 C<interface> Implementation

    MetaPOD::Format::JSON::interface->add_v1( $data->{interface} , $metapod_result );

=cut

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
