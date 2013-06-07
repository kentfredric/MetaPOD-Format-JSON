#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use Data::Dump qw(pp);
use Path::Tiny qw(path);
use Path::Iterator::Rule;
use MetaPOD::Assembler;
use GraphViz;

my $output = path($FindBin::Bin);

my $root = path($FindBin::Bin)->parent()->child('lib');

my $rule = Path::Iterator::Rule->new()->name(qr/^.*.pm/);
my $it   = $rule->iter("$root");

my $assembler = MetaPOD::Assembler->new();
my $g         = GraphViz->new(
  rankdir => 'LR',

  #  ratio   => 'compress',
  node => { 'shape' => 'box' },
);

my $clusters = {};

while ( my $file = $it->() ) {
  my $result = $assembler->assemble_file($file);

  my $cluster = [];
  for my $interface ( $result->interface ) {
    push @$cluster, $interface;
  }
  my $cluster_str;
  if ( @{$cluster} ) {
    $cluster_str = join q{,}, @{$cluster};
  }

  if ( $cluster_str and not exists $clusters->{$cluster_str} ){
      $clusters->{$cluster_str} = {
          name => $cluster_str ,
          color => 'green',
      };
      $g->add_node(  $result->namespace => cluster => $clusters->{$cluster_str} );
  } elsif ( $cluster_str and exists $clusters->{$cluster_str} ) {
      $g->add_node(  $result->namespace => cluster => $clusters->{$cluster_str} );
  } else {
      $g->add_node( $result->namespace );
  }
  $g->add_edge( $result->namespace, $_, label => 'inherits', color => 'red',  dir => 'forward' ) for $result->inherits;
  $g->add_edge( $result->namespace, $_, label => 'does',     color => 'blue', dir => 'forward' ) for $result->does;
}

$output->child('self_structure.dot')->spew( $g->as_debug );
$output->child('self_structure.png')->spew_raw( $g->as_png);


