#!/bin/bash

# Invoked by:
#
# sbatch TopHat.sh 
#

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 16  				
#SBATCH --time=1-6:00  	
#SBATCH --mem=30GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
#module load tophat/2.1.1-foss-2015b
#module load SAMtools/1.2-foss-2015b
#module load Bowtie2/2.2.6-foss-2015b
#module load Python/3.5.1-intel-2015c

LEFTREADS=Mut-F2-Rep1_CGTACG_L007_R1.fastq.gz,Mut-F2-Rep2_GCCAAT_L008_R1.fastq.gz,Mut-F2-Rep3_GTGAAA_L008_R1.fastq.gz,Mut-F5-Rep1_ACAGTG_L008_R1.fastq.gz,Mut-F5-Rep2_CAGATC_L008_R1.fastq.gz,Mut-F5-Rep3_CTTGTA_L008_R1.fastq.gz,WT-F2-Rep1_ATCACG_L007_R1.fastq.gz,WT-F2-Rep2_TAGCTT_L007_R1.fastq.gz,WT-F5-Rep1_ACTTGA_L007_R1.fastq.gz,WT-F5-Rep2_GGCTAC_L007_R1.fastq.gz,WT-F5-Rep3_GTGGCC_L007_R1.fastq.gz
RIGHTREADS=Mut-F2-Rep1_CGTACG_L007_R2.fastq.gz,Mut-F2-Rep2_GCCAAT_L008_R2.fastq.gz,Mut-F2-Rep3_GTGAAA_L008_R2.fastq.gz,Mut-F5-Rep1_ACAGTG_L008_R2.fastq.gz,Mut-F5-Rep2_CAGATC_L008_R2.fastq.gz,Mut-F5-Rep3_CTTGTA_L008_R2.fastq.gz,WT-F2-Rep1_ATCACG_L007_R2.fastq.gz,WT-F2-Rep2_TAGCTT_L007_R2.fastq.gz,WT-F5-Rep1_ACTTGA_L007_R2.fastq.gz,WT-F5-Rep2_GGCTAC_L007_R2.fastq.gz,WT-F5-Rep3_GTGGCC_L007_R2.fastq.gz

multiHit=("20" "25" "30" "35" "40")
mismatch=("1" "2" "3" "4" "5")
gap=("1" "2" "3" "4" "5")

for iHit in "${multiHit[@]}"; do 
	for iMatch in "${mismatch[@]}"; do
		for iGap in "${gap[@]}"; do

#Run alignment for mouse
 			tophat -o="../aligned" -micro-exon-search -no-mixed -no-discordant ${iHit} ${iMatch} ${iGap} mm10 ${LEFTREADS}  ${RIGHTREADS}
 			#echo "hits: ${iHit}, mismatches: ${iMatch}, gaps: ${iGap}" >> listFiles.txt


 			#2> outputTopHat.log
		done
	done
done

# genome index base: mm10
# first comma delimited group: RNA seq reads of Read1 (Paired ends used)
# second comma delimited group: RNA seq reads of Read2
## Options to alter: 
# -g: maximum multi-hits default is 20
# -N: alignments with more than N mismatches are discarded. Default 2
# -read-gap-length: read alignments with more than n length gaps will be discarded. Default is 2
## Options to keep constant:
# -o: output directory
# -no-discordant: report only concordant mappings
# -no-mixed: report only when both reads can be mapped
# -micro-exon-search: searches for tiny exons 
# -i: minimum intron length default is 70 