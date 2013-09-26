
use strict;
use warnings;

package MetaPOD::Output::JSON::v1_1;
BEGIN {
  $MetaPOD::Output::JSON::v1_1::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Output::JSON::v1_1::VERSION = '0.2.4';
}

use Moo;
extends 'MetaPOD::Output::JSON::v1';
with 'MetaPOD::Output::JSON::interface::v1_1';

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Output::JSON::v1_1

=head1 VERSION

version 0.2.4

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Output::JSON::v1_1",
    "interface":"single_class",
    "does":[
        "MetaPOD::Output::JSON::interface::v1_1"
    ],
    "inherits":"MetaPOD::Output::JSON::v1"
}


=end MetaPOD::JSON

sub features {
    return qw( does inherits namespace interface );
}

1;

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
