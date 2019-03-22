use strict;
use warnings;
use diagnostics;

use feature 'switch';

my $fh;
my $dna_file;
my $dna_seq;
my $rna_seq;
my $harf;
my @triplets;
my $i;
my $j = 0;

my %code_table = (
  "UUU" => "F", "UUC" => "F", "UUA" => "L", "UUG" => "L", "CUU" => "L",
  "CUC" => "L", "CUA" => "L", "CUG" => "L", "AUU" => "I", "AUC" => "I",
  "AUA" => "I", "AUG" => "M", "GUU" => "V", "GUC" => "V", "GUA" => "V",
  "GUG" => "V", "UCU" => "S", "UCC" => "S", "UCA" => "S", "UCG" => "S",
  "CCU" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P", "ACU" => "T",
  "ACC" => "T", "ACA" => "T", "ACG" => "T", "GCU" => "A", "GCC" => "A",
  "GCA" => "A", "GCG" => "A", "UAU" => "Y", "UAC" => "Y", "UAA" => "STOP",
  "UAG" => "STOP", "CAU" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
  "AAU" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K", "GAU" => "D",
  "GAC" => "D", "GAA" => "E", "GAG" => "E", "UGU" => "C", "UGC" => "C",
  "UGA" => "STOP", "UGG" => "W", "CGU" => "R", "CGC" => "R", "CGA" => "R",
  "CGG" => "R", "AGU" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
  "GGU" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G"
);

$dna_file = "dna.txt";

open($fh, '<', $dna_file)
	or die("Dosya okunamadi : $!");
	
$dna_seq = <$fh>;

close($fh) or die("Dosya kapatilamadi : $!");

$rna_seq = "";

foreach $harf (split('', $dna_seq)) {
   given($harf) {
   	when( $_ eq 'A' ) {
		$rna_seq = $rna_seq . 'U';
   	}
   	when( $_ eq 'T' ) {
		$rna_seq = $rna_seq . 'A';
   	}
   	when( $_ eq 'C' ) {
		$rna_seq = $rna_seq . 'G';
   	}
   	when( $_ eq 'G' ) {
		$rna_seq = $rna_seq . 'C';
   	}
   }
}
$triplets[$j] = "";
for ( $i=0; $i<length($rna_seq); $i++ ) {
	$triplets[$j] = $triplets[$j].substr( $rna_seq, $i , 1 );
	if($i%3 == 2){
		$triplets[$j+1] = "";
		$j++;
	}
}

print("DNA Dizisi: ", $dna_seq, "\n");
print("RNA Dizisi: ", $rna_seq, "\n");

print("Tripletler: ");
for my $triplet (@triplets){
  print($triplet, " ");
}
print("\n");

$j = 0;
print("Protein: ");
while($triplets[$j] ne "") {
	print($code_table{$triplets[$j]});
	$j++;
}
print("\n");
