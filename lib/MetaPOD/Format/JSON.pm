use strict;
use warnings;

package MetaPOD::Format::JSON;

# ABSTRACT: Reference implementation of a C<JSON> based MetaPOD Format

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON",
    "inherits":"Moo::Object",
    "does":"MetaPOD::Role::Format",
    "interface": "single_class"
}

=end MetaPOD::JSON

=head1 SYNOPSIS

This is the reference implementation of L<< C<MetaPOD::JSON>|MetaPOD::JSON >>

=cut

use Moo;
use Carp qw( croak );
use version 0.77;

with 'MetaPOD::Role::Format';

use MetaPOD::Format::JSON::v1;
use MetaPOD::Format::JSON::v1_1;

my $dispatch_table = [
  {
    version => version->parse('v1.0.0'),
    handler => 'MetaPOD::Format::JSON::v1'
  },
  {
    version => version->parse('v1.1.0'),
    handler => 'MetaPOD::Format::JSON::v1_1'
  }
];

=method C<supported_versions>

The versions this module supports

    returns qw( v1.0.0 v1.1.0 )

=cut

sub supported_versions {
  return qw( v1.0.0 v1.1.0 );
}

=method C<add_segment>

See L<< C<::Role::Format>|MetaPOD::Role::Format >> for the specification of the C<add_segment> method.

=cut

sub add_segment {
  my ( $self, $segment, $result ) = @_;
  my $segver = $self->supports_version( $segment->{version} );
  for my $v ( @{$dispatch_table} ) {
    next unless $v->{version} == $segver;
    $v->{handler}->add_segment( $segment, $result );
    return $result;
  }
  croak "No implementation found for version $segver";
}

1;
