use strict;
use warnings;

package MetaPOD::Spec;

# ABSTRACT: The Specification of the MetaPOD format

=begin MetaPOD::JSON v1.1.0

{ "namespace":"MetaPOD::Spec" }

=end MetaPOD::JSON

=cut

1;

=head1 Specifying MetaPOD

=head2 FORMATS

A FORMAT is a MetaPOD Subclass.

Segments will be parsed looking for

    MetaPOD::([^\s]+)

Where C<$1> is the name of the MetaPOD C<FORMAT>

e.g:

    =begin MetaPOD::JSON

    { JSON DATA }

    =end MetaPOD::JSON

These may, or may not, correspond to real world parser names, but the actual code loaded
may be determined by the parser, and this declaration is more an indication of a I<specification>

And it may be that a C<MetaPOD::JSON> declaration loads MetaPOD::Format::JSON


=head2 VERSIONS

A VERSION as part of a Segment declaration B<must> come after the format declaration, preceded only by white-space.

A VERSION declaration B<must> start with a C<v>

ALL VERSIONS will be assumed to be dotted-decimal, and parsed with the 'v' included.

These versions however do not necessarily have to map to a C<CPAN> Version, and is instead supposed to be an indication of the I<specification> version, a specification that may be provided by multiple C<CPAN> packages/versions.

What this means to the I<specification> is at the whim of the format, and it is the formats job to respond to a version declaration.

C<FORMATS> may either

=over 4

=item * reject a version as being "too new" and thus not supported by a back end

=item * change behaviour based on the value of this version

=item * reject a version as being "too old" to be supported by the back end

=back

=head2 Segment Declaration

A MetaPOD specification can be added to a POD document via one of the following forms

=head3 Block Segments

    =begin MetaPOD::FORMAT

    FORMATDATA

    =end MetaPOD::FORMAT

And

    =begin MetaPOD::FORMAT VERSION

    FORMATDATA

    =end MetaPOD::FORMAT

=head3 One Line Segments

    =for MetaPOD::FORMAT FORMATDATA

and

    =for MetaPOD::FORMAT VERSION FORMATDATA

=head2 Multiple Segment Declaration

It is the design of this Spec to recommend that segment declarations B<Should> be permissible
to be declared multiple times, and it B<should> use this information to gather data progressively,
merging data as it goes.


