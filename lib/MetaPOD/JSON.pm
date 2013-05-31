use strict;
use warnings;

# ABSTRACT: The JSON Formatted MetaPOD Spec

package MetaPOD::JSON;
BEGIN {
  $MetaPOD::JSON::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::JSON::VERSION = '0.1.0';
}


sub implementation_class { return 'MetaPod::Format::JSON' }

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::JSON - The JSON Formatted MetaPOD Spec

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

This is mostly a documentation stub, documenting the JSON Formatted version of MetaPOD

The Actual Implementation is stored in L<< C<::Format::JSON>|MetaPOD::Format::JSON >>

=begin MetaPOD::JSON v1.0.0

{ "namespace":"MetaPOD::JSON" }


=end MetaPOD::JSON

=for Pod::Coverage implementation_class

=head1 Using MetaPOD::JSON in your documentation

    =begin MetaPOD::JSON

    {  "valid_json_data":"goes_here" }

    =end

or

    =for MetaPOD::JSON { valid_json_data }

    =cut

You can also declare a version for which semantics to embue into the declaration.

    =begin MetaPOD::JSON v1.0.0

as Per L<< C<::Spec>|MetaPOD::Spec >>, the "v" is required, and the version semantics are always dotted decimal.

Note: As Per L<< C<::Spec>|MetaPOD::Spec >>, the version is B<NOT> a minimum version requirement, but a declaration of the versions semantics the containing declaration is encoded in. Given implementations B<MAY> support multiple versions, or they B<MAY NOT> support multiple versions.

It is B<ENCOURAGED> that wherever possible to support the B<WIDEST> variety of versions.

=head1 SPEC VERSION v1.0.0

=head2 Data collection

Spec version 1.0.0 is such that mutliple declarations should be merged to form an aggregate,

ie:

    =for MetaPOD::JSON v1.0.0 { "a":"b" }

    =for MetaPOD::JSON v1.0.0 { "c":"d" }

this should be the same  as if one had done

    =begin MetaPOD::JSON v1.0.0

    {
        "a" : "b"
        "c" : "d"
    }

    =end MetaPOD::JSON

With the observation that latter keys may clobber preceeding keys.

=head2 Scope

Because of the Data Collection design, it is not supported to declare multiple namespaces
within the same file at present.

This is mostly a practical consideration, as without this consideration, all declarations of class members would require re-stating the class, and that would quickly become tiresome.

=head2 KEYS

=head3 namespace

All C<MetaPOD::JSON> containing documents B<SHOULD> contain at least one namespace declaration.

Example:

    { "namespace": "My::Library" }

=head3 inherits

Any C<MetaPOD::JSON> containing document that is known to inherit from another class, B<SHOULD> document their inheritance as such:

    { "inherits": [ "Moose::Object" ]}

C<inherits> can be in one of 2 forms.

    { "inherits" : $string }
    { "inherits" : [ $string, $string, $string ] }

Both will perform logically appending either the string, or the list of elements, to an internal list which is deduplciated.

So that

    { "inherits" : [ $a ]}
    { "inherits" : [ $b ]}

And

    { "inherits" : $a }
    { "inherits" : $b }

Have the same effect, the result being the same as if you had specified

    { "inherits" : [ $a, $b ] }

=head3 does

Any C<MetaPOD::JSON> containing document that is known to "do" another role, B<SHOULD> document their inheritance as such:

    { "does": [ "Some::Role" ]}

C<does> can be in one of 2 forms.

    { "does" : $string }
    { "does" : [ $string, $string, $string ] }

Both will perform logically appending either the string, or the list of elements, to an internal list which is deduplciated.

So that

    { "does" : [ $a ]}
    { "does" : [ $b ]}

And

    { "does" : $a }
    { "does" : $b }

Have the same effect, the result being the same as if you had specified

    { "does" : [ $a, $b ] }

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
