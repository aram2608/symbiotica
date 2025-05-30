#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Symbiotica::Parser qw(parse);
use Symbiotica::Finder qw(find_patterns);

# === CONFIGURATION ===
my $input     = "data/genomic.gbff";       # GenBank file
my $format    = "genbank";                 # gff or genbank
my $motifs    = "data/motifs.txt";         # motif regexes
# ======================

# === STEP 1: Parse features from GenBank or GFF + FASTA ===
my $features = parse($input, $format);

# === STEP 2: Find matching features based on motif regexes ===
my $hits = find_patterns($features, $motifs);

# === STEP 3: Print matches to STDOUT ===
print join("\t", qw(SEQID TYPE START END MATCH)), "\n";
for my $f (@$hits) {
    print join("\t",
        $f->{seq_id},
        $f->{type},
        $f->{start},
        $f->{end},
        $f->{match}
    ), "\n";
}
