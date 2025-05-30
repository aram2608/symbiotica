use lib './lib';
use Symbiotica::Parser qw(parse);

my $features = parse("data/genomic.gbff", "genbank");
for my $f (@$features) {
    print "$f->{seq_id}\t$f->{type}\t$f->{start}-$f->{end}\n";
}