use strict;
use warnings;

package MetaPOD::Format::JSON;
BEGIN {
  $MetaPOD::Format::JSON::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::VERSION = '0.2.1';
}

# ABSTRACT: Reference implementation of a C<JSON> based MetaPOD Format


use Moo;
use Carp qw( croak );
use version 0.77;

with 'MetaPOD::Role::Format';

use MetaPOD::Format::JSON::namespace;
use MetaPOD::Format::JSON::inherits;
use MetaPOD::Format::JSON::does;
use MetaPOD::Format::JSON::interface;
use MetaPOD::Format::JSON::Decoder;
use MetaPOD::Format::JSON::PostCheck;


my $dispatch_table = [
  {
    version => version->parse('v1.0.0'),
    method  => 'v1',
  },
  {
    version => version->parse('v1.1.0'),
    method  => 'v1_1',
  }
];

my $decode_table = {
    'v1' => {
        Decoder => 'v1',
        PostCheck => 'v1',
    },
    'v1_1' => {
        Decoder => 'v1',
        PostCheck => 'v1',
    },
};

my $feature_table = {
    'v1' => {
        namespace => 'v1',
        inherits  => 'v1',
        does      => 'v1',
    },
    'v1_1' => {
        namespace => 'v1',
        inherits  => 'v1',
        does      => 'v1',
        interface => 'v1_1',
    },
};


sub supported_versions {
  return qw( v1.0.0 v1.1.0 );
}

sub _add_segment_auto {
    my ( $self, $data_decoded, $vspec, $result ) = @_;
    my $features = $feature_table->{$vspec};
    for my $feature ( keys %$features ) { 
        my $impl = $features->{$feature};
        my $namespace = 'MetaPOD::Format::JSON::' . $feature;
        my $method    = 'add_' . $impl;
        next unless exists $data_decoded->{$feature};
        my $copy = delete $data_decoded->{$feature};
        $namespace->$method( $copy, $result );
    }
    return $self;
}
sub _json_decode {
    my ( $self, $data, $spec ) = @_;
    my $namespace = 'MetaPOD::Format::JSON::Decoder';
    my $method    = 'decoder_' . $decode_table->{$spec}->{'Decoder'};
    return $namespace->$method( $data );
}
sub _postcheck {
    my ( $self, $data, $spec ) = @_;
    my $namespace = 'MetaPOD::Format::JSON::PostCheck';
    my $method    = 'postcheck_' . $decode_table->{$spec}->{'PostCheck'};
    return $namespace->$method( $data );
}

sub _add_segment_v1 {
  my ( $self, $data, $result ) = @_;
  require JSON;
  my $data_decoded = JSON->new->decode($data);
  $self->_add_segment_auto( $data_decoded, 'v1', $result );
  if ( keys %{$data_decoded} ) {
    croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data_decoded} ) . '>';
  }
  return $result;
}

sub _add_segment_v1_1 {
  my ( $self, $data, $result ) = @_;
  require JSON;
  my $data_decoded = JSON->new->decode($data);
  $self->_add_segment_auto( $data_decoded, 'v1_1', $result );
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
    my $data = $self->_json_decode( $segment->{data}, $v->{method} );
    $self->_add_segment_auto( $data, $v->{method}, $result );
    $self->_postcheck( $data, $v->{method} );
    return $result;
  }
  croak "No implementation found for version $segver";
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON - Reference implementation of a C<JSON> based MetaPOD Format

=head1 VERSION

version 0.2.1

=head1 SYNOPSIS

This is the reference implementation of L<< C<MetaPOD::JSON>|MetaPOD::JSON >>

=head1 METHODS

=head2 supported_versions

The versions this module supports

    returns qw( v1.0.0 v1.1.0 )

=head2 add_segment

See L<< C<::Role::Format>|MetaPOD::Role::Format >> for the specification of the C<add_segment> method.

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON",
    "inherits":"Moo::Object",
    "does":"MetaPOD::Role::Format",
    "interface": "single_class"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
