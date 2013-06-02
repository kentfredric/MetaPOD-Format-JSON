use strict;
use warnings;

package MetaPOD;

# ABSTRACT: An evolution of POD

=begin MetaPOD::JSON v1.0.0

{ "namespace":"MetaPOD" }

=end MetaPOD::JSON

=cut

=head1 What is MetaPOD

=head2 1. Documentation About Documentation

MetaPOD is a system intended to express the relationships between different documents, and express the importance and context of other things within the documents, and express how the documents as a whole fit together

=head2 2. Documentation about Meta

MetaPOD also is a system by which one can express relationships about code, code which has documentation, but how the documentation is related to other documentation requires you to normally understand the meta-level information within the code works, so, this system aims to make the "meta level" more visible from the surface, so the meta-level information can be more easily used to

=over 4

=item * Aggregate multiple documents to a single document in line with how the Meta layer works

=item * Show pretty graphs and things showing how classes are related to each other

=back

=head1 What can MetaPOD do for me

At present, there is not much built on top of the MetaPOD api, so it is marginally limited.

And at present, there is not much on CPAN with MetaPOD annotations, so any such functionality is presently limited by that.

However, for a taste of what we might see with widespread use of MetaPOD, here is what we can easily determine from the present API, with the existing annotations in within MetaPOD itself: http://kentfredric.github.io/MetaPOD/media/self_structure.png

=begin html

<center><img src="http://kentfredric.github.io/MetaPOD/media/self_structure.png" width="549px" height="507px" /></center>

=end html

=begin markdown

![Graphviz Graph of MetaPOD](http://kentfredric.github.io/MetaPOD/media/self_structure.png)

=end markdown

=head1 People who are writing MetaPOD

Eventually, the goal is to have the MetaPOD itself able to be generated via tools during development, so that the meta-layer information is cemented into the POD itself, before, or during release.

In that vein, I hope to make a C<Dist::Zilla> plug-in that does this for you.

In the mean time, the documents you want to be reading are

=over 4

=item * L<< C<MetaPOD::Spec>|MetaPOD::Spec >> - The general specification for all forms of MetaPOD

=item * L<< C<MetaPOD::JSON>|MetaPOD::JSON >> - Information specific to the C<JSON> based implementation of MetaPOD

=back

=head1 People who are wanting to read MetaPOD

=over 4

=item * L<< C<MetaPOD::Assembler>|MetaPOD::Assembler >> - The tool that translates documents containing C<MetaPOD> into L<< C<MetaPOD::Result> Objects|MetaPOD::Result >>

=back

=cut

1;
