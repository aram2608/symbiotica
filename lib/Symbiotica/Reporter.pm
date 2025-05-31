# lib/Symbiotica/Reporter.pm

package Symbiotica::Reporter;

use strict;
use warnings;
use Exporter 'import';
use File::Spec;
use File::Path qw(make_path);
our @EXPORT_OK = qw(write_all);

sub write_all {
    my ($hits, $outdir) = @_;

    make_path($outdir) unless -d $outdir;

    _write_tsv($hits, File::Spec->catfile($outdir, 'symbiotica_matches.tsv'));
    _write_gff($hits, File::Spec->catfile($outdir, 'symbiotica_matches.gff'));
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

1;
