#!/usr/bin/perl
use strict;
use warnings;

# Open the input FASTQ file
open(my $fastq_in, "<", "Toto_R1_mini.fastq.txt") or die "Could not open input file: $!";

# Open the output FASTA file
open(my $fasta_out, ">", "fasta.txt") or die "Could not open output file: $!";

# Read through the FASTQ file
while (my $line = <$fastq_in>) {
    chomp($line);
    
    # Check if line starts with @, indicating a sequence ID
    if ($line =~ /^@/) {
        # Print the ID line in FASTA format
        print $fasta_out ">", substr($line, 1), "\n";  # Remove the "@" and replace with ">"
        
        # Get the next line which contains the sequence
        my $sequence = <$fastq_in>;
        chomp($sequence);
        print $fasta_out "$sequence\n";
        
        # Skip the "+" line and the quality score line
        <$fastq_in>;  # Skip "+"
        <$fastq_in>;  # Skip quality scores
    }
}

# Close the file handles
close($fastq_in);
close($fasta_out);

print "Conversion to FASTA format completed successfully.\n";
