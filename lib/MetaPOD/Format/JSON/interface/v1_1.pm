use strict;
use warnings;

package MetaPOD::Format::JSON::interface::v1_1;

# ABSTRACT: Implementation of JSON/interface format component

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::interface::v1_1",
    "interface":"role"
}

=end MetaPOD::JSON

=cut

use Moo::Role;
use Carp qw(croak);

=method supported_interfaces

Spec v1.1 C<interface> value list.

    my @valid_interface_tokens = __SOME_CLASS__->supported_interfaces

=cut

sub supported_interfaces {
  return qw( class role type_library exporter single_class function );
}

=method check_interface

Spec v1.1 C<interface> Implementation key checking routine

    __SOME_CLASS__->check_interface( $interface, $interface, $interface );

Simply goes C<bang> if C<$interface> is not in C<supported_interfaces_v1_1>

=cut

sub check_interface {
  my ( $self, @ifs ) = @_;
  my $supported = { map { ( $_, 1 ) } $self->supported_interfaces_v1_1 };
  for my $if (@ifs) {
    if ( not exists $supported->{$if} ) {
      croak("interface type $if unsupported in v1.1.0");
    }
  }
  return $self;
}

=method add_interface

Spec v1.1 C<interface> Implementation

    __SOME_CLASS->add_interface( $data->{interface} , $metapod_result );

=cut

sub add_interface {
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
