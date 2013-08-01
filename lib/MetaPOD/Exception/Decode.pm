
use strict;
use warnings;

package MetaPOD::Exception::Decode;
BEGIN {
  $MetaPOD::Exception::Decode::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Exception::Decode::VERSION = '0.2.2';
}

use Moo;

extends 'MetaPOD::Exception';

has 'file' => ( is => ro =>, required => 1 );

has 'internal_message' => ( is => ro =>, required => 1 );

has '+message' => (
    is      => ro =>,
    lazy    => 1,
    builder => sub {
        return "While decoding " . $_[0]->file . ": " . $_[0]->internal_message;
    }
);

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Exception::Decode

=head1 VERSION

version 0.2.2

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
