use strict;
use warnings;

package MetaPOD::Format::JSON;
BEGIN {
  $MetaPOD::Format::JSON::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::VERSION = '0.1.0';
}

# ABSTRACT: Reference implementation of a JSON based MetaPOD Format


use Moo;
use Carp qw( croak );
use version 0.77;

with 'MetaPOD::Role::Format';

my $dispatch_table = [
  {
    version => version->parse('v1.0.0'),
    method  => 'v1',
  }
];


sub supported_versions {
  return qw( v1.0.0 );
}

sub _do_for_key {
  my ( $stash, $key, $code ) = @_;
  return unless exists $stash->{$key};
  my $copy = delete $stash->{$key};
  local $_ = $copy;
  return $code->($_);
}


sub _add_namespace_v1 {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

sub _add_inherits_v1 {
  my ( $self, $inherits, $result ) = @_;
  if ( defined $inherits and not ref $inherits ) {
    return $result->add_inherits($inherits);
  }
  if ( defined $inherits and ref $inherits eq 'ARRAY' ) {
    return $result->add_inherits( @{$inherits} );
  }
  croak 'Unsupported reftype ' . ref $inherits;
}

sub _add_segment_v1 {
  my ( $self, $data, $result ) = @_;
  require JSON;
  my $data_decoded = JSON->new->decode($data);
  _do_for_key(
    $data_decoded => 'namespace' => sub {
      $self->_add_namespace_v1( $_, $result );
    }
  );
  _do_for_key(
    $data_decoded => 'inherits' => sub {
      $self->_add_inherits_v1( $_, $result );
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
    my $method = $self->can( '_add_segment_' . $v->{method} );
    return $method->( $self, $segment->{data}, $result );
  }
  croak "No implementation found for version $segver";
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON - Reference implementation of a JSON based MetaPOD Format

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

This is the reference implementation of L<< C<MetaPOD::JSON>|MetaPOD::JSON >>

=head1 METHODS

=head2 supported_versions

The versions this module supports

    returns qw( v1.0.0 )

=head2 add_segment

See L<< C<::Role::Format>|MetaPOD::Role::Format >> for the specification of the C<add_segment> method.

=begin MetaPOD::JSON v1.0.0

{
    "namespace":"MetaPOD::Format::JSON",
    "inherits":"Moo::Object"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
