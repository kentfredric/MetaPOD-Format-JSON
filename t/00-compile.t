use strict;
use warnings;

# This test was generated via Dist::Zilla::Plugin::Test::Compile 2.014

use Test::More 0.88;



use Capture::Tiny qw{ capture };

my @module_files = qw(
MetaPOD.pm
MetaPOD/Assembler.pm
MetaPOD/Exception.pm
MetaPOD/Exception/Decode.pm
MetaPOD/Exception/Decode/Data.pm
MetaPOD/Extractor.pm
MetaPOD/Format/JSON.pm
MetaPOD/Format/JSON/Decoder/v1.pm
MetaPOD/Format/JSON/PostCheck/v1.pm
MetaPOD/Format/JSON/does/v1.pm
MetaPOD/Format/JSON/inherits/v1.pm
MetaPOD/Format/JSON/interface/v1_1.pm
MetaPOD/Format/JSON/namespace/v1.pm
MetaPOD/Format/JSON/v1.pm
MetaPOD/Format/JSON/v1_1.pm
MetaPOD/JSON.pm
MetaPOD/Result.pm
MetaPOD/Role/Format.pm
MetaPOD/Spec.pm
);

my @scripts = qw(

);

# no fake home requested

my @warnings;
for my $lib (@module_files)
{
    my ($stdout, $stderr, $exit) = capture {
        system($^X, '-Mblib', '-e', qq{require qq[$lib]});
    };
    is($?, 0, "$lib loaded ok");
    warn $stderr if $stderr;
    push @warnings, $stderr if $stderr;
}

is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};





done_testing;
