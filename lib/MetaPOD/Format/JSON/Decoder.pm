use strict;
use warnings;

package MetaPOD::Format::JSON::Decoder;
BEGIN {
  $MetaPOD::Format::JSON::Decoder::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::Decoder::VERSION = '0.2.1';
}

# ABSTRACT: C<JSON> to Structure translation layer



sub decoder_v1 {
  my ( $self, $data ) = @_;
  require JSON;
  return JSON->new->decode($data);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::Decoder - C<JSON> to Structure translation layer

=head1 VERSION

version 0.2.1

=head1 METHODS

=head2 decoder_v1

Spec V1 C<JSON> Decoder

    my $hash = MetaPOD::Format::JSON::Decoder->decoder_v1( $json_string );

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::Decoder",
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
