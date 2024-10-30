#!/usr/bin/perl
use strict;

# Ouvre le fichier FASTQ en entrée (lecture)
open(my $fastq_in, "<", "Toto_R1_mini.fastq.txt") or die "Impossible d'ouvrir le fichier d'entrée : $!";

# Ouvre le fichier QUAL en sortie (écriture)
open(my $qual_out, ">", "qual.txt") or die "Impossible d'ouvrir le fichier de sortie : $!";

# Définit la correspondance des scores de qualité
my %quality_mapping = (
    '!' => '0',
    '"' => '1',
    '#' => '2',
    '$' => '3',
    '%' => '4',
    '&' => '5',
    "'" => '6',
    '(' => '7',
    ')' => '8',
    '*' => '9',
    '+' => '10',
    ',' => '11',
    '-' => '12',
    '.' => '13',
    '/' => '14',
    '0' => '15',
    '1' => '16',
    '2' => '17',
    '3' => '18',
    '4' => '19',
    '5' => '20',
    '6' => '21',
    '7' => '22',
    '8' => '23',
    '9' => '24',
    ':' => '25',
    ';' => '26',
    '<' => '27',
    '=' => '28',
    '>' => '29',
    '?' => '30',
    '@' => '31',
    'A' => '32',
    'B' => '33',
    'C' => '34',
    'D' => '35',
    'E' => '36',
    'F' => '37',
    'G' => '38',
    'H' => '39',
    'I' => '40',
    'J' => '41'
);

# Lit le fichier FASTQ ligne par ligne
while (my $line = <$fastq_in>) {
    chomp($line);
    
    # Vérifie si la ligne commence par @, indiquant un identifiant de séquence
    if ($line =~ /^@/) {
        # Ignore la ligne suivante (ligne de séquence)
        <$fastq_in>;
        
        # Ignore la ligne contenant "+"
        <$fastq_in>;
        
        # Récupère la ligne des scores de qualité
        my $quality_line = <$fastq_in>;
        chomp($quality_line);
        
        # Convertit les scores de qualité en valeurs numériques
        my @quality_scores = map { $quality_mapping{$_} } split(//, $quality_line);
        
        # Imprime les scores de qualité dans le fichier de sortie
        print $qual_out join(" ", @quality_scores), "\n";
    }
}

# Ferme les fichiers
close($fastq_in);
close($qual_out);

# Affiche un message indiquant que la conversion est terminée
print "Conversion au format QUAL terminée avec succès.\n";
