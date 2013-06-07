
use strict;
use warnings;

package MetaPOD::Format::JSON::namespace;
BEGIN {
  $MetaPOD::Format::JSON::namespace::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::namespace::VERSION = '0.2.1';
}

# ABSTRACT: Implementation of JSON/namespace format component



sub add_v1 {
  my ( $self, $namespace, $result ) = @_;
  return $result->set_namespace($namespace);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::namespace - Implementation of JSON/namespace format component

=head1 VERSION

version 0.2.1

=head1 METHODS

=head2 add_v1

Spec V1 C<namespace> Implementation

    MetaPOD::Format::JSON::namespace->add_v1( $data->{namespace} , $metapod_result );

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::namespace",
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
