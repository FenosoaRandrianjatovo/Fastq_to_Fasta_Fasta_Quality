#!/opt/homebrew/bin/perl



$text = "Toto_R1_mini.fastq.txt";hjvjhgv
open (MYFILE, "$text");
$ligne = <MYFILE>;
# print "$ligne[1]";
# print $ligne;

print "\n \n  \n ";
@new = (2);
while ($ligne =<MYFILE>){
    @list_de_mots= split(//, $ligne);
    push(@new, @list_de_mots);fgf
}
print $new;
# print @list_de_mots;

# print "\n \n ";

# print $list_de_mots[100];





