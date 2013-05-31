use strict;
use warnings;

package MetaPOD::Assembler;

# ABSTRACT: Glue layer that dispatches segments to a constructed Result

=begin MetaPOD::JSON v1.0.0

{
    "namespace":"MetaPOD::Assembler",
    "inherits":"Moo::Object"
}

=end MetaPOD::JSON

=cut

use Moo;
use Carp qw( croak );
use Module::Runtime qw( use_module );

has 'result' => (
  is       => ro =>,
  required => 0,
  lazy     => 1,
  builder  => sub {
    require MetaPOD::Result;
    return MetaPOD::Result->new();
  },
  clearer => 'clear_result',
);

has extractor => (
  is       => ro =>,
  required => 1,
  lazy     => 1,
  builder  => sub {
    my $self = shift;
    require MetaPOD::Extractor;
    return MetaPOD::Extractor->new(
      end_segment_callback => sub {
        my $segment = shift;
        $self->handle_segment($segment);
      },
    );
  },
);

has format_map => (
  is       => ro =>,
  required => 1,
  lazy     => 1,
  builder  => sub {
    return { 'JSON' => 'MetaPOD::Format::JSON', };
  },
);

sub assemble_handle {
  my ( $self, $handle ) = @_;
  $self->clear_result;
  $self->extractor->read_handle($handle);
  return $self->result;
}

sub assemble_file {
  my ( $self, $file ) = @_;
  $self->clear_result;
  $self->extractor->read_file($file);
  return $self->result;
}

sub assemble_string {
  my ( $self, $string ) = @_;
  $self->clear_result;
  $self->extractor->read_string($string);
  return $self->result;
}

sub get_class_for_format {
  my ( $self, $format ) = @_;
  if ( not exists $self->format_map->{$format} ) {
    croak "format $format unsupported";
  }
  return $self->format_map->{$format};
}

sub handle_segment {
  my ( $self, $segment ) = @_;
  my $format  = $segment->{format};
  my $version = $segment->{version};
  my $data    = $segment->{data};

  my $class = $self->get_class_for_format($format);
  use_module($class);

  return unless $class->supports_version($version);

  $class->add_segment( $segment, $self->result );

}

1;
