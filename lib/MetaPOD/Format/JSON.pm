use strict;
use warnings;

package MetaPOD::Format::JSON;

# ABSTRACT: Reference implementation of a JSON based MetaPOD Format

=begin MetaPOD::JSON v1.0.0

{
    "namespace":"MetaPOD::Format::JSON",
    "inherits":"Moo::Object"
}

=end MetaPOD::JSON

=cut

use Moo;
use Carp qw( croak );
use version 0.77;

with "MetaPOD::Role::Format";

my $dispatch_table = [
  {
    version => version->parse('v1.0.0'),
    method  => 'v1',
  }
];

sub supported_versions {
  return qw( v1.0.0 );
}

sub do_for_key {
  my ( $stash, $key, $code ) = @_;
  return unless exists $stash->{$key};
  my $copy = delete $stash->{$key};
  local $_ = $copy;
  return $code->($_);
}

sub add_namespace_v1 {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

sub add_inherits_v1 {
  my ( $self, $inherits, $result ) = @_;
  if ( defined $inherits and not ref $inherits ) {
    return $result->add_inherits($inherits);
  }
  if ( defined $inherits and ref $inherits eq 'ARRAY' ) {
    return $result->add_inherits( @{$inherits} );
  }
  croak 'Unsupported reftype ' . ref $inherits;
}

sub add_segment_v1 {
  my ( $self, $data, $result ) = @_;
  require JSON;
  my $data_decoded = JSON->new->decode($data);
  do_for_key(
    $data_decoded,
    'namespace',
    sub {
      $self->add_namespace_v1( $_, $result );
    }
  );
  do_for_key(
    $data_decoded,
    'inherits',
    sub {
      $self->add_inherits_v1( $_, $result );
    }
  );
  if ( keys %{$data_decoded} ) {
    croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data_decoded} ) . '>';
  }
  return $result;
}

sub add_segment {
  my ( $self, $segment, $result ) = @_;
  my $segver = $self->supports_version( $segment->{version} );
  for my $v ( @{$dispatch_table} ) {
    next unless $v->{version} == $segver;
    my $method = $self->can( 'add_segment_' . $v->{method} );
    return $method->( $self, $segment->{data}, $result );
  }
  croak "No implementation found for version $segver";
}

1;
