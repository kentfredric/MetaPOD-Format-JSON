#!/usr/bin/env perl 

use strict;
use warnings;

use FindBin;
use Data::Dump qw(pp);
use Path::Tiny qw(path);
use Path::Iterator::Rule;
use MetaPOD::Assembler;
use GraphViz;

my $root = path($FindBin::Bin)->parent()->child('lib');

my $rule = Path::Iterator::Rule->new()->name(qr/^.*.pm/);
my $it   = $rule->iter("$root");

my $assembler = MetaPOD::Assembler->new();
my $g         = GraphViz->new();

while ( my $file = $it->() ) {
  my $result = $assembler->assemble_file($file);
  $g->add_node( $result->namespace );
  $g->add_edge( $result->namespace, $_, label => 'inherits' ) for $result->inherits;
  $g->add_edge( $result->namespace, $_, label => 'does' )     for $result->does;

}

print $g->as_debug;

