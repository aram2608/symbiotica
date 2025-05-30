#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Symbiotica::Parser qw(parse);

my $features = parse("data/genomic.gbff", "genbank");
for my $f (@$features) {
    print "$f->{seq_id}\t$f->{type}\t$f->{start}-$f->{end}\n";
}