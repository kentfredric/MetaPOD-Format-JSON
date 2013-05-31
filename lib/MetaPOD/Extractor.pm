use strict;
use warnings;

package MetaPOD::Extractor;

# ABSTRACT: Extract MetaPOD declarations from a file.
use Moo;
extends 'Pod::Eventual';

=begin MetaPOD::JSON v1.0.0

{
    "namespace": "MetaPOD::Extractor",
    "inherits" : "Pod::Eventual"
}

=end MetaPOD::JSON

=cut

use Data::Dump qw(pp);
use Carp qw(croak);

has formatter_regexp => (
  is      => ro  =>,
  lazy    => 1,
  builder => sub { qr/MetaPOD::([^[:space:]]+)/sxm },
);

has version_regexp => (
  is      => ro  =>,
  lazy    => 1,
  builder => sub { qr/(v[[:digit:].]+)/sxm },
);

has regexp_begin_with_version => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    my $formatter_regexp = $_[0]->formatter_regexp;
    my $version_regexp   = $_[0]->version_regexp;
    qr{ ^ ${formatter_regexp} \s+ ${version_regexp} \s* $ }smx;
  },
);

has regexp_begin => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    my $formatter_regexp = $_[0]->formatter_regexp;
    qr{ ^ ${formatter_regexp} \s* $ }smx;
  },
);

has regexp_for_with_version => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    my $formatter_regexp = $_[0]->formatter_regexp;
    my $version_regexp   = $_[0]->version_regexp;
    qr{ ^ ${formatter_regexp} \s+ ${version_regexp} \s+ ( .*$ ) }smx;
  },
);

has regexp_for => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    my $formatter_regexp = $_[0]->formatter_regexp;
    qr{ ^ ${formatter_regexp} \s+ ( .* $ ) $ }smx;
  },
);

has end_segment_callback => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    sub { }
  },
);

=method set_segment_cache

    $extactor->set_segment_cache({})

=cut

has segment_cache => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_segment_cache',
  builder => sub { {} },
);

=method set_segments

    $extractor->set_segments([])

=cut

has segments => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_segments',
  builder => sub { [] },
);

=method set_in_segment

    $extractor->set_in_segment(1)

=cut

=method unset_in_segment

    $extractor->unset_in_segment()

=cut

has in_segment => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_in_segment',
  clearer => 'unset_in_segment',
  builder => sub { undef },
);

=method begin_segment

    $extractor->begin_segment( $format, $version, $start_line );

=cut

sub begin_segment {
  my ( $self, $format, $version, $start_line ) = @_;
  $self->set_segment_cache(
    {
      format     => $format,
      start_line => $start_line,
      ( defined $version ? ( version => $version ) : () ),
    }
  );
  $self->set_in_segment(1);
  return $self;
}

=method end_segment

    $extractor->end_segment();

=cut

sub end_segment {
  my ($self) = @_;
  my $segment = $self->segment_cache;
  push @{ $self->segments }, $segment;
  $self->set_segment_cache( {} );
  $self->unset_in_segment();
  my $cb = $self->end_segment_callback;
  $cb->($segment);
  return $self;
}

=method append_segment_data

    $extractor->append_segment_data( $string_data )

=cut

sub append_segment_data {
  my ( $self, $data ) = @_;
  $self->segment_cache->{data} ||= q{};
  $self->segment_cache->{data} .= $data;
  return $self;
}

=method add_segment

    $extractor->add_segment( $format, $version, $data, $start_line );

=cut

sub add_segment {
  my ( $self, $format, $version, $data, $start_line ) = @_;
  my $segment = {};
  $segment->{format}     = $format;
  $segment->{version}    = $version if defined $version;
  $segment->{data}       = $data;
  $segment->{start_line} = $start_line if defined $start_line;

  push @{ $self->segments }, $segment;
  my $cb = $self->end_segment_callback;
  $cb->($segment);

  return $self;
}

=method handle_begin

    $extractor->handle_begin( $POD_EVENT );

=cut

sub handle_begin {
  my ( $self, $event ) = @_;
  if ( $self->in_segment ) {
    croak '=begin MetaPOD:: cannot occur inside =begin MetaPOD:: at line ' . $event->{start_line};
  }
  if ( $event->{content} =~ $self->regexp_begin_with_version ) {
    return $self->begin_segment( $1, $2, $event->{start_line} );
  }
  if ( $event->{content} =~ $self->regexp_begin ) {
    return $self->begin_segment( $1, undef, $event->{start_line} );
  }
  return $self->handle_ignored($event);
}

=method handle_end

    $extractor->handle_end( $POD_EVENT );

=cut

sub handle_end {
  my ( $self, $event ) = @_;
  chomp $event->{content};
  my $statement = q{=} . $event->{command} . q{ } . $event->{content};

  if ( not $self->in_segment and not $event->{content} =~ $self->regexp_begin ) {
    return $self->handle_ignored($event);
  }

  if ( $self->in_segment ) {
    my $expected_end = '=end MetaPOD::' . $self->segment_cache->{format};
    if ( $statement ne $expected_end ) {
      croak "$statement seen but expected $expected_end at line " . $event->{start_line};
    }
    return $self->end_segment();
  }
  if ( $event->{content} =~ $self->regexp_begin ) {
    croak "unexpected $statement without =begin MetaPOD::$1 at line" . $event->{start_line};
  }
  return $self->handle_ignored($event);
}

=method handle_for

    $extractor->handle_for( $POD_EVENT );

=cut

sub handle_for {
  my ( $self, $event ) = @_;
  if ( $event->{content} =~ $self->regexp_for_with_version ) {
    return $self->add_segment( $1, $2, $3, $event->{start_line} );
  }
  if ( $event->{content} =~ $self->regexp_for ) {
    return $self->add_segment( $1, undef, $2, $event->{start_line} );
  }
  return $self->handle_ignored($event);
}

=method handle_cut

    $extractor->handle_cut( $POD_EVENT );

=cut

sub handle_cut {
  my ( $self, $element ) = @_;
  return $self->handle_ignored($element);
}

=method handle_text

    $extractor->handle_text( $POD_EVENT );

=cut

sub handle_text {
  my ( $self, $element ) = @_;
  return $self->handle_ignored($element) unless $self->in_segment;
  return $self->append_segment_data( $element->{content} );
}

=method handle_ignored

    $extractor->handle_ignored( $POD_EVENT );

=cut

sub handle_ignored {
  my ( $self, $element ) = @_;
  if ( $self->in_segment ) {
    croak 'Unexpected type ' . $element->{type} . ' inside segment ' . pp($element) . ' at line' . $element->{start_line};
  }
}

=method handle_event

    $extractor->handle_event( $POD_EVENT );

=cut

sub handle_event {
  my ( $self, $event ) = @_;
  for my $command (qw( begin end for cut )) {
    last unless $event->{type} eq 'command';
    next unless $event->{command} eq $command;
    my $method = $self->can( 'handle_' . $command );
    return $self->$method($event);
  }
  if ( $event->{type} eq 'text' ) {
    return $self->handle_text($event);
  }
  return $self->handle_ignored($event);

}

1;
