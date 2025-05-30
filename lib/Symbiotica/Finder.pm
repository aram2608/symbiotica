# lib/Symbiotica/Finder.pm

package Symbiotica::Finder;

use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(find_patterns);

sub find_patterns {
    my ($features, $pattern_file) = @_;
    my %patterns = _load_patterns($pattern_file);

    my @hits;

    for my $feat (@$features) {
        for my $pat_name (keys %patterns) {
            my $regex = $patterns{$pat_name};

            # Try to match against type and tag strings
            if ($feat->{type} =~ /$regex/i || $feat->{tags} =~ /$regex/i) {
                push @hits, {
                    %$feat,             # carry original data
                    match => $pat_name, # matched pattern label
                    pattern => $regex,  # actual regex string
                };
            }
        }
    }

    return \@hits;
}

sub _load_patterns {
    my ($file) = @_;
    open my $fh, "<", $file or die "Can't open pattern file: $file\n";

    my %patterns;
    while (<$fh>) {
        chomp;
        next if /^\s*#/ || !/\S/;  # skip empty/comment lines
        my ($label, $regex) = split /\t/, $_, 2;
        $patterns{$label} = qr/$regex/;
    }

    return %patterns;
}

1;  # Perl needs this for modules