# lib/Symbiotica/Finder.pm

package Symbiotica::Finder; # Works like Symbiotica.Finder in Python, the naming scheme for Perl is a bit different when it comes to naming modules and packages and stuff

use strict; # This and the warnings are best practice Perl usage, help you not write bad code
use warnings;
use Exporter 'import';
use Symbiotica::Motifs qw(get_motifs);
our @EXPORT_OK = qw(find_patterns);

# Main function for finding patterns in the genbank file
sub find_patterns {
    my ($features) = @_; # The features array come from the Parser.pm and pattern file is our predefined regexes
    my %patterns = get_motifs();

    my @hits; # prepares an empty list to store matched genes

    # Loop for matching regexes to the genbank
    for my $feat (@$features) {
        for my $pat_name (keys %patterns) {
            my $regex = $patterns{$pat_name};

            # Try to match against type and tag strings
            # If the feature’s type or its tags match the regex (case-insensitive)
            if ($feat->{type} =~ /$regex/ || $feat->{tags} =~ /$regex/) {
                push @hits, {           # push adds data to our list
                    %$feat,             # carry original data
                    match => $pat_name, # matched pattern label
                    pattern => $regex,  # actual regex string
                };
            }
        }
    }

    return \@hits;
}

1;  # Perl needs this for modules