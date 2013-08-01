
use strict;
use warnings;

package MetaPOD::Format::JSON::v1;
BEGIN {
  $MetaPOD::Format::JSON::v1::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::v1::VERSION = '0.2.2';
}

# ABSTRACT: MetaPOD::JSON v1 SPEC Implementation

use Moo;


with 'MetaPOD::Format::JSON::Decoder::v1',
  'MetaPOD::Format::JSON::PostCheck::v1',
  'MetaPOD::Format::JSON::does::v1',
  'MetaPOD::Format::JSON::inherits::v1',
  'MetaPOD::Format::JSON::namespace::v1';

sub features {
  return qw( does inherits namespace );
}

sub dispatch_keys {
  my ( $self, $data_decoded, $result ) = @_;
  for my $feature ( $self->features ) {
    my $method = 'add_' . $feature;
    next unless exists $data_decoded->{$feature};
    my $copy = delete $data_decoded->{$feature};
    $self->$method( $copy, $result );
  }
  return $self;
}

sub add_segment {
  my ( $self, $segment, $result ) = @_;
  my $data = $self->decode( $segment->{data} );
  $self->dispatch_keys( $data, $result );
  $self->postcheck($data);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::v1 - MetaPOD::JSON v1 SPEC Implementation

=head1 VERSION

version 0.2.2

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::v1",
    "interface":"single_class",
    "inherits":"Moo::Object",
    "does":[
        "MetaPOD::Format::JSON::Decoder::v1",
        "MetaPOD::Format::JSON::PostCheck::v1",
        "MetaPOD::Format::JSON::does::v1",
        "MetaPOD::Format::JSON::inherits::v1",
        "MetaPOD::Format::JSON::namespace::v1"
    ]
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
