use strict;
use warnings;

package MetaPOD::Output::JSON;
BEGIN {
  $MetaPOD::Output::JSON::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Output::JSON::VERSION = '0.2.4';
}

# ABSTRACT: JSON Output Formatter


use Moo;
use version 0.77;
with 'MetaPOD::Role::Output';

use MetaPOD::Output::JSON::v1;
use MetaPOD::Output::JSON::v1_1;

my $dispatch_table = [
  {
    version => version->parse('v1.0.0'),
    handler => 'MetaPOD::Output::JSON::v1',
  },
  {
    version => version->parse('v1.1.0'),
    handler => 'MetaPOD::Output::JSON::v1_1',
  }
];


sub supported_versions {
  return qw( v1.0.0 v1.1.0 );
}


sub output_metapod {
  my ( $self, $version, $result ) = @_;
  my $segver = $self->supports_version($version);
  for my $v ( @{$dispatch_table} ) {
    next unless $v->{version} == $segver;
    return $v->{handler}->output_metapod($result);
  }
  croak "No implementation found for version $segver";
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Output::JSON - JSON Output Formatter

=head1 VERSION

version 0.2.4

=head1 METHODS

=head2 C<supported_versions>

    my @supported_versions = $impl->supported_versions();

    # v1.0.0 v1.1.0

=head2 C<output_metapod>

    my $string = MetaPOD::Output::JSON->output_meta( 'v1.1.0' => $result_object )

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Output::JSON",
    "interface":"single_class",
    "does":"MetaPOD::Role::Output",
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
