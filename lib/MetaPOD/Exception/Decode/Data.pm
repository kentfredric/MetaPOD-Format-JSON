
use strict;
use warnings;

package MetaPOD::Exception::Decode::Data;
BEGIN {
  $MetaPOD::Exception::Decode::Data::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Exception::Decode::Data::VERSION = '0.2.2';
}

# ABSTRACT: Failures with decoding source data

use Moo;



extends 'MetaPOD::Exception';

has 'data' => ( is => ro =>, required => 1 );

has 'internal_message' => ( is => ro =>, required => 1 );

has '+message' => (
    is      => ro =>,
    lazy    => 1,
    builder => sub {
        return "While decoding:\n" . $_[0]->data . "\n Got: " . $_[0]->internal_message;
    }
);

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Exception::Decode::Data - Failures with decoding source data

=head1 VERSION

version 0.2.2

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Exception::Decode::Data",
    "interface":"class",
    "inherits":"MetaPOD::Exception"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
