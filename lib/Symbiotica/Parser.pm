# lib/Symbiotica/Parser.pm

package Symbiotica::Parser;

use strict;
use warnings;
use Bio::SeqIO;
use Bio::Tools::GFF;
use Exporter 'import';
our @EXPORT_OK = qw(parse);

# This module takes a genbank or gff and extracts its features for downstream use in the Finder.pm module
# Main entry point, checks for file and matches file type
sub parse {
    my ($file, $format) = @_;
    die "File not found: $file\n" unless -e $file;

    if ($format eq 'genbank') {
        return _parse_genbank($file);
    } elsif ($format eq 'gff') {
        return _parse_gff($file);
    } else {
        die "Unsupported format: $format\n";
    }
}

sub _parse_genbank {
    my ($file) = @_;
    my $seqio = Bio::SeqIO->new(-file => $file, -format => 'genbank');

    my @features;

    while (my $seq = $seqio->next_seq) {
        for my $feat ($seq->get_SeqFeatures) {
            my $type  = $feat->primary_tag;
            my $start = $feat->start;
            my $end   = $feat->end;
            my $strand = $feat->strand;
            my $tags  = join(",", $feat->get_all_tags);

            push @features, {
                type   => $type,
                start  => $start,
                end    => $end,
                strand => $strand,
                tags   => $tags,
                seq_id => $seq->display_id,
            };
        }
    }

    return \@features;
}

sub _parse_gff {
    my ($file) = @_;
    my $gffio = Bio::Tools::GFF->new(-file => $file, -gff_version => 3);

    my @features;

    while (my $feat = $gffio->next_feature) {
        push @features, {
            type   => $feat->primary_tag,
            start  => $feat->start,
            end    => $feat->end,
            strand => $feat->strand,
            tags   => join(",", $feat->get_all_tags),
            seq_id => $feat->seq_id,
        };
    }

    return \@features;
}

1;  # Has to end in this, Perl will yell at you otherwise
