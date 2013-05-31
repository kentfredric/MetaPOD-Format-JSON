use strict;
use warnings;

package MetaPOD::Extractor;
BEGIN {
  $MetaPOD::Extractor::AUTHORITY = 'cpan:KENTNL';
}
{
  $MetaPOD::Extractor::VERSION = '0.1.0';
}

# ABSTRACT: Extract MetaPOD declarations from a file.
use Moo;
extends 'Pod::Eventual';

use Data::Dump qw(pp);

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

has segment_cache => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_segment_cache',
  builder => sub { {} },
);

has segments => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_segments',
  builder => sub { [] },
);

has in_segment => (
  is      => ro  =>,
  lazy    => 1,
  writer  => 'set_in_segment',
  clearer => 'unset_in_segment',
  builder => sub { undef },
);

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

sub end_segment {
  my ($self) = @_;
  push @{ $self->segments }, $self->segment_cache;
  $self->set_segment_cache( {} );
  $self->unset_in_segment();
  return $self;
}

sub append_segment_data {
  my ( $self, $data ) = @_;
  $self->segment_cache->{data} ||= '';
  $self->segment_cache->{data} .= $data;
  return $self;
}

sub add_segment {
  my ( $self, $format, $version, $data, $start_line ) = @_;
  my $segment = {};
  $segment->{format}     = $format;
  $segment->{version}    = $version if defined $version;
  $segment->{data}       = $data;
  $segment->{start_line} = $start_line if defined $start_line;

  push @{ $self->segments }, $segment;
  return $self;
}

sub handle_begin {
  my ( $self, $event ) = @_;
  if ( $self->in_segment ) {
    die "=begin MetaPOD:: cannot occur inside =begin MetaPOD:: at line " . $event->{start_line};
  }
  if ( $event->{content} =~ $self->regexp_begin_with_version ) {
    return $self->begin_segment( $1, $2, $event->{start_line} );
  }
  if ( $event->{content} =~ $self->regexp_begin ) {
    return $self->begin_segment( $1, undef, $event->{start_line} );
  }
  return $self->handle_ignored($event);
}

sub handle_end {
  my ( $self, $event ) = @_;
  chomp $event->{content};
  my $statement = '=' . $event->{command} . ' ' . $event->{content};

  if ( not $self->in_segment and not $event->{content} =~ $self->regexp_begin ) {
    return $self->handle_ignored($event);
  }

  if ( $self->in_segment ) {
    my $expected_end = '=end MetaPOD::' . $self->segment_cache->{format};
    if ( $statement ne $expected_end ) {
      die "$statement seen but expected $expected_end at line " . $event->{start_line};
    }
    return $self->end_segment();
  }
  if ( $event->{content} =~ $self->regexp_begin ) {
    die "unexpected $statement without =begin MetaPOD::$1 at line" . $event->{start_line};
  }
  return $self->handle_ignored($event);
}

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

sub handle_cut { }

sub handle_text {
  my ( $self, $element ) = @_;
  return $self->handle_ignored($element) unless $self->in_segment;
  return $self->append_segment_data( $element->{content} );
}

sub handle_ignored {
  my ( $self, $element ) = @_;
  if ( $self->in_segment ) {
    die "Unexpected type " . $element->{type} . " inside segment " . pp($element) . " at line" . $element->{start_line};
  }
}

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

__END__

=pod

=encoding utf-8

=head1 NAME

MetaPOD::Extractor - Extract MetaPOD declarations from a file.

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
