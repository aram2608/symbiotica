# lib/Symbiotica/Motifs.pm

package Symbiotica::Motifs;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(get_motifs);

sub get_motifs {
    return (
        'nifH' => qr/\bnifH\b/i,
        'nodA' => qr/\bnodA\b/i,
        'fixX' => qr/\bfixX\b/i,
        'cas'  => qr/\bcas\d+\b/i,
        'ccm'  => qr/\bccm[A-Z]*\b/i,
        'exo'  => qr/\bexo[A-Z]?\b/i,
    );
}

1;