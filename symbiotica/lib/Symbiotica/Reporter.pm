# lib/Symbiotica/Reporter.pm

package Symbiotica::Reporter;

use strict;
use warnings;
use Exporter 'import';
use File::Spec;
use File::Path qw(make_path);
our @EXPORT_OK = qw(write_all);

sub write_all {
    my ($hits, $outdir, $input_file, $format) = @_;

    make_path($outdir) unless -d $outdir;

    _write_tsv($hits, File::Spec->catfile($outdir, 'symbiotica_matches.tsv'));
    _write_gff($hits, File::Spec->catfile($outdir, 'symbiotica_matches.gff'));

    if ($format eq 'genbank') {
        _write_fasta($hits, $input_file, File::Spec->catfile($outdir, 'symbiotica_hits.fasta'));
    } else {
        warn "FASTA output only supported for GenBank files.\n";
    }
}

sub _write_tsv {
    my ($hits, $path) = @_;

    open my $fh, '>', $path or die "Cannot write TSV: $path\n";

    print $fh join("\t", qw(seq_id type start end strand match pattern tags)), "\n";
    for my $h (@$hits) {
        print $fh join("\t",
            $h->{seq_id},
            $h->{type},
            $h->{start},
            $h->{end},
            $h->{strand},
            $h->{match},
            $h->{pattern},
            $h->{tags}
        ), "\n";
    }

    close $fh;
}

sub _write_gff {
    my ($hits, $path) = @_;

    open my $fh, '>', $path or die "Cannot write GFF: $path\n";

    print $fh "##gff-version 3\n";
    for my $h (@$hits) {
        my $attributes = "ID=$h->{match}_$h->{start};Note=Matched:$h->{match}";
        print $fh join("\t",
            $h->{seq_id},
            "Symbiotica",
            $h->{type},
            $h->{start},
            $h->{end},
            ".",
            $h->{strand} == 1 ? "+" : ($h->{strand} == -1 ? "-" : "."),
            ".",
            $attributes
        ), "\n";
    }

    close $fh;
}

sub _write_fasta {
    my ($hits, $gbk_file, $fasta_path) = @_;

    require Bio::SeqIO;
    my $seqio = Bio::SeqIO->new(-file => $gbk_file, -format => 'genbank');

    # Build hash of sequence objects by ID
    my %seqs;
    while (my $seq = $seqio->next_seq) {
        $seqs{ $seq->display_id } = $seq;
    }

    open my $fh, '>', $fasta_path or die "Cannot write FASTA: $fasta_path\n";

    for my $h (@$hits) {
        my $seq_obj = $seqs{ $h->{seq_id} };
        next unless $seq_obj;

        my $subseq = $seq_obj->subseq($h->{start}, $h->{end});
        $subseq = revcomp($subseq) if $h->{strand} == -1;

        print $fh ">$h->{match}|$h->{seq_id}:$h->{start}-$h->{end}\n";
        print $fh format_fasta($subseq), "\n";
    }

    close $fh;
}

sub revcomp {
    my ($dna) = @_;
    $dna =~ tr/ACGTacgt/TGCAtgca/;
    return scalar reverse $dna;
}

sub format_fasta {
    my ($seq) = @_;
    $seq =~ s/(.{1,60})/$1\n/g;
    return $seq;
}

1;
