#!/usr/bin/perl
use strict;

# Active le mode strict de Perl, qui aide à détecter les erreurs courantes
# comme l'utilisation de variables non déclarées. C'est une bonne pratique pour
# écrire un code plus sûr et plus fiable.

# Ouvre le fichier FASTQ en entrée (lecture)
open(my $fastq_in, "<", "Toto_R1_mini.fastq.txt") or die "Could not open input file: $!";
# La commande `open` ouvre le fichier "Toto_R1_mini.fastq.txt" en mode lecture ("<").
# Si le fichier ne peut pas être ouvert, la fonction `die` termine le programme et
# affiche un message d'erreur.

# Ouvre le fichier FASTA en sortie (écriture)
open(my $fasta_out, ">", "fasta.txt") or die "Could not open output file: $!";
# La commande `open` ouvre le fichier "fasta.txt" en mode écriture (">").
# Si le fichier ne peut pas être ouvert, `die` termine le programme avec un message d'erreur.

# Lit le fichier FASTQ ligne par ligne
while (my $line = <$fastq_in>) {
    chomp($line);
    # La boucle `while` lit chaque ligne du fichier d'entrée.
    # `chomp($line)` supprime le caractère de fin de ligne (comme "\n") de `$line`.

    # Vérifie si la ligne commence par "@", ce qui indique un ID de séquence
    if ($line =~ /^@/) {
        # Si la ligne commence par "@" (début d'un en-tête de séquence dans un fichier FASTQ),
        # cela signifie que c'est un identifiant de séquence.

        # Imprime la ligne ID dans le format FASTA
        print $fasta_out ">", substr($line, 1), "\n";
        # Remplace le "@" par ">" pour le format FASTA, et écrit la ligne modifiée dans le fichier de sortie.
        # `substr($line, 1)` prend la sous-chaîne en commençant à partir du deuxième caractère,
        # c'est-à-dire qu'il enlève le "@" initial.

        # Obtient la ligne suivante qui contient la séquence
        my $sequence = <$fastq_in>;
        chomp($sequence);
        # Lit la séquence qui suit l'ID et enlève le caractère de fin de ligne.
        
        # Écrit la séquence dans le fichier de sortie
        print $fasta_out "$sequence\n";

        # Ignore la ligne "+" et la ligne de score de qualité
        <$fastq_in>;  # Ignore la ligne contenant juste "+"
        <$fastq_in>;  # Ignore la ligne contenant les scores de qualité associés
        # Les fichiers FASTQ ont une ligne "+" après la séquence, puis une ligne de scores de qualité.
        # Ces deux lignes ne sont pas nécessaires pour le format FASTA.
    }
}

# Ferme les fichiers d'entrée et de sortie
close($fastq_in);
close($fasta_out);
# Toujours fermer les fichiers une fois qu'on a terminé de les lire ou de les écrire.

# Affiche un message indiquant que la conversion est terminée
print "Conversion to FASTA format completed successfully.\n";
