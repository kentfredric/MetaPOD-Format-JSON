
use strict;
use warnings;

package MetaPOD::Role::Format;
BEGIN {
  $MetaPOD::Role::Format::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Role::Format::VERSION = '0.1.0';
}

use Moo::Role;
use Carp qw( croak );
use version 0.77;

sub supported_versions { return qw( v1.0.0 ) }

sub _supported_versions {
  my $class = shift;
  return map { version->parse($_) } $class->supported_versions;
}

sub supports_version {
  my ( $class, $version ) = @_;
  if ( $version !~ /^v/msx ) {
    croak q{Version specification does not begin with a 'v'};
  }
  my $v = version->parse($version);
  for my $supported ( $class->supported_versions ) {
    return $supported if $supported == $v;
  }
  croak "Version $v not supported. Supported versions: " . join q{,}, $class->supported_versions;
}

requires 'new_collector';
requires 'add_segment';

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Role::Format

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
