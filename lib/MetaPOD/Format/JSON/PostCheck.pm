use strict;
use warnings;

package MetaPOD::Format::JSON::PostCheck;
BEGIN {
  $MetaPOD::Format::JSON::PostCheck::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Format::JSON::PostCheck::VERSION = '0.2.1';
}

# ABSTRACT: Handler for unrecognised tokens in JSON


sub postcheck_v1 {
    my ( $self, $data , $result ) = @_; 
  
    if ( keys %{$data} ) {
        croak 'Keys found not supported in this version: <' . ( join q{,}, keys %{$data} ) . '>';
    }
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Format::JSON::PostCheck - Handler for unrecognised tokens in JSON

=head1 VERSION

version 0.2.1

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"MetaPOD::Format::JSON::PostCheck",
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
