# lib/Symbiotica/Printer.pm

package Symbiotica::Printer;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(print_stdout);

sub print_stdout {
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
}