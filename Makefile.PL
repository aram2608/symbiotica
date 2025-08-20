use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Symbiotica',
    VERSION      => '0.1',
    EXE_FILES    => ['symbiotica/bin/symbiotica.pl'],
    PREREQ_PM    => {
        'Getopt::Long'    => 0,
        'Bio::Perl'       => 0,
        'Bio::SeqIO'      => 0,
        'Bio::Tools::GFF' => 0,
        'File::Path'      => 0,
        'File::Spec'      => 0,
        'Exporter'        => 0,
    },
    LIBS         => [''],
    DEFINE       => '',
    INC          => '-Ilib',
    INSTALLDIRS  => 'site',
);
