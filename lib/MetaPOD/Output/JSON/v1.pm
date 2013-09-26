
use strict;
use warnings;

package MetaPOD::Output::JSON::v1;
BEGIN {
  $MetaPOD::Output::JSON::v1::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Output::JSON::v1::VERSION = '0.2.4';
}


use Moo;
with 'MetaPOD::Output::JSON::Encoder::v1', 'MetaPOD::Output::JSON::does::v1', 'MetaPOD::Output::JSON::inherits::v1';
'MetaPOD::Output::JSON::namespace::v1';

sub features {
  return qw( does inherits namespace );
}

sub get_feature {
  my ( $self, $feature, $result ) = @_;
  my $method = 'get_' . $feature;
  return $self->$method($result);
}

sub output_metapod {
  my ( $self, $result ) = @_;
  my $data = {};
  for my $feature ( $self->features ) {
    $data->{$feature} = $self->get_feature( $feature, $result );
  }
  return $self->encode($data);
}

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Output::JSON::v1

=head1 VERSION

version 0.2.4

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Output::JSON::v1",
    "interface":"single_class",
    "does":[
        "MetaPOD::Output::JSON::Encoder::v1",
        "MetaPOD::Output::JSON::does::v1",
        "MetaPOD::Output::JSON::inherits::v1",
        "MetaPOD::Output::JSON::namespace::v1"
    ],
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
