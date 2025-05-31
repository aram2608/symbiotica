#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Getopt::Long;
use Symbiotica::Parser qw(parse);
use Symbiotica::Finder qw(find_patterns);
use Symbiotica::Reporter qw(write_all);

my ($input, $format, $motifs, $outdir);

# Command line argument options
GetOptions(
    "input=s"   => \$input,
    "format=s"  => \$format,
    "outdir=s"  => \$outdir,
) or die "Invalid command-line arguments\n";

die "Usage: $0 --input FILE --format genbank|gff--outdir DIR\n"
    unless $input && $format && $outdir;

my $features = parse($input, $format);
my $hits = find_patterns($features);
write_all($hits, $outdir, $input, $format);