use strict;
use warnings;

package MetaPOD::Output::JSON::namespace::v1;
BEGIN {
  $MetaPOD::Output::JSON::namespace::v1::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Output::JSON::namespace::v1::VERSION = '0.2.4';
}

use Moo::Role;


sub get_namespace {
  my ( $self, $result ) = @_;
  my $i = 0;
  for my $ns ( $result->namespace ) {
    die "v1 cannot support namespace => [ REF ]" if ref $ns;
    die "v1 cannot support >1 namespaces" if $i > 0;
    $i++;
  }
  return $result->namespace;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Output::JSON::namespace::v1

=head1 VERSION

version 0.2.4

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Output::JSON::namespace::v1",
    "interface":"role"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
