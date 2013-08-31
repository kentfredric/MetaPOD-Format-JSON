use strict;
use warnings;

# ABSTRACT: The C<JSON> Formatted MetaPOD Spec

package MetaPOD::JSON;
BEGIN {
  $MetaPOD::JSON::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::JSON::VERSION = '0.2.3';
}


sub implementation_class { return 'MetaPod::Format::JSON' }

1;

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::JSON - The C<JSON> Formatted MetaPOD Spec

=head1 VERSION

version 0.2.3

=head1 SYNOPSIS

This is mostly a documentation stub, documenting the C<JSON> Formatted version of MetaPOD

The Actual Implementation is stored in L<< C<::Format::JSON>|MetaPOD::Format::JSON >>

=begin MetaPOD::JSON v1.1.0

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

You can also declare a version for which semantics to imbue into the declaration.

    =begin MetaPOD::JSON v1.0.0

as Per L<< C<::Spec>|MetaPOD::Spec >>, the "v" is required, and the version semantics are always dotted decimal.

Note: As Per L<< C<::Spec>|MetaPOD::Spec >>, the version is B<NOT> a minimum version requirement, but a declaration of the versions semantics the containing declaration is encoded in. Given implementations B<MAY> support multiple versions, or they B<MAY NOT> support multiple versions.

It is B<ENCOURAGED> that wherever possible to support the B<WIDEST> variety of versions.

=head1 SPEC VERSION v1.1.0

This version of the spec is mostly identical to L</SPEC VERSION v1.0.0>, and it B<MUST> support all features
of that version, with the following additions.

=head2 interface

There are many ways for Perl Name spaces to behave, and this property indicates what style of interfaces a given name space supports.

SPEC VERSION v1.1.0 Supports 6 interface types:

=over 4

=item * C<class> - Indicating the given name space has a constructor of some kind, which returns a C<bless>'ed object.

For instance, if your synopsis looks like this:

    use Foo;
    my $instance = Foo->new();
    $instance->();

Then you should include C<class> in your L</interface> list.

=item * C<role> - Indicating the given C<namespace> is a "role" of some kind, and cannot be instantiated, only composed into other C<class>es.

For instance, if your synopsis looks like this:

    package Foo;
    use Moo;
    with "YourNameSpace";

You should include C<role> in your L</interface> list.

=item * C<exporter> - Indicating the given C<namespace> C<exports> things into the caller

For instance, if your synopsis looks like this:

    use Foo qw( func );
    use Foo;
    bar(); # Exported by Foo

Then you should include C<exporter> in your L</interface> list.

This includes things like C<Moo> and C<Moose> which export functions like C<has> into the calling C<namespace>.

=item * C<functions> - Indicating a C<namespace> which has functions intended to be called via fully qualified names.

For instance, if your synopsis looks like this:

    use Foo;
    Foo::bar();

Then you should include C<functions> in your L</interface> list.

=item * C<single_class> - A Hybrid between C<functions> and C<class>, a C<namespace> which has methods, but no constructor, and the C<namespace> itself behaves much like a singleton.

For instance, if your synopsis looks like this:

    use Foo;
    Foo->set_thing( 1 );

Then you should include C<singleclass> in your L</interface> list.

These usages are also candidates for C<singleclass> L</interface>es.

    Foo->copy( $a , $b ); # a and/or b is modified, but no object is returned
    my $result = Foo->bar(); # $result is not an object

However, this is not an example of the C<single_class> interface:

    use Foo;
    my $instance = Foo->writer( $bar );
    $instance->method();

Because here, C<writer> doesn't modify the state of C<Foo>, and C<writer> could be seen as simply an alternative constructor.

=item * C<type_library> - A Type Library of some kind.

For instance, if your class uses C<Moose::Util::TypeConstraints> to create a named type of some kind, and that type is accessible via

    has Foo => (
        isa => 'TypeName'
    );

Then you want to include C<type_library> in your L</interface> list.

Note: Some type libraries, notably L<< C<MooseX::Types>|MooseX::Types >> perform type creation in I<addition> to exporting, and for such libraries, you should include both C<type_library> and C<exporter>

=back

Name spaces that meet above definitions B<SHOULD> document such interfaces as such:

    { "interface": [ "class", "exporter" ]}

C<interface> can be in one of 2 forms.

    { "interface" : $string }
    { "interface" : [ $string, $string, $string ] }

Both will perform logically appending either the string, or the list of elements, to an internal list which is deduplicated.

So that

    { "interface" : [ $a ]}
    { "interface" : [ $b ]}

And

    { "interface" : $a }
    { "interface" : $b }

Have the same effect, the result being the same as if you had specified

    { "interface" : [ $a, $b ] }

=head1 SPEC VERSION v1.0.0

=head2 Data collection

Spec version 1.0.0 is such that multiple declarations should be merged to form an aggregate,

e.g.:

    =for MetaPOD::JSON v1.0.0 { "a":"b" }

    =for MetaPOD::JSON v1.0.0 { "c":"d" }

this should be the same  as if one had done

    =begin MetaPOD::JSON v1.0.0

    {
        "a" : "b"
        "c" : "d"
    }

    =end MetaPOD::JSON

With the observation that latter keys may clobber preceding keys.

=head2 Scope

Because of the Data Collection design, it is not supported to declare multiple name-spaces
within the same file at present.

This is mostly a practical consideration, as without this consideration, all declarations of class members would require re-stating the class, and that would quickly become tiresome.

=head2 KEYS

=head3 C<namespace>

All C<MetaPOD::JSON> containing documents B<SHOULD> contain at least one C<namespace> declaration.

Example:

    { "namespace": "My::Library" }

=head3 C<inherits>

Any C<MetaPOD::JSON> containing document that is known to inherit from another class, B<SHOULD> document their inheritance as such:

    { "inherits": [ "Moose::Object" ]}

C<inherits> can be in one of 2 forms.

    { "inherits" : $string }
    { "inherits" : [ $string, $string, $string ] }

Both will perform logically appending either the string, or the list of elements, to an internal list which is deduplicated.

So that

    { "inherits" : [ $a ]}
    { "inherits" : [ $b ]}

And

    { "inherits" : $a }
    { "inherits" : $b }

Have the same effect, the result being the same as if you had specified

    { "inherits" : [ $a, $b ] }

=head3 C<does>

Any C<MetaPOD::JSON> containing document that is known to "do" another role, B<SHOULD> document their inheritance as such:

    { "does": [ "Some::Role" ]}

C<does> can be in one of 2 forms.

    { "does" : $string }
    { "does" : [ $string, $string, $string ] }

Both will perform logically appending either the string, or the list of elements, to an internal list which is deduplicated.

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
