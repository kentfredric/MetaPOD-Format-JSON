use strict;
use warnings;

package MetaPOD::Exception;
BEGIN {
  $MetaPOD::Exception::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Exception::VERSION = '0.2.2';
}

use Moo;


extends 'Throwable::Error';

no Moo;

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Exception

=head1 VERSION

version 0.2.2

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Exception",
    "interface":"class",
    "inherits":"Throwable::Error"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
