#!/bin/bash

# Invoked by:
#
# sbatch indexSTAR.sh 
# RUN THIS FROM THE SCRIPTS FOLDER. IT RELIES ON A RELATIVE PATH!!!

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-04:00  	
#SBATCH --mem=30GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


multiMap=("20" "25" "30" "35" "40" "45")
mismatch=("2" "5" "10" "15" "20")

# Load the necessary modules
module load STAR/2.5.1a-foss-2015b

# build with STAR
for iMap in "${multiMap[@]}"; do
for iMatch in "${mismatch[@]}"; do

STAR --genomeDir ../mouse/indexed/ --readFilesIn /data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/raw_data/read1/ /data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/raw_data/read2 --outFilterMismatchNmax ${mismatch} --outFilterMultimapNmax ${multiMap} --outFileNamePrefix ../mouse/output/mm10 --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No 

2> outputSTAR.log

done 
done

# outSAMstrandField intronMotif:Allows compatability with Cufflinks
# outSAMattributes All: Provides all SAM attributes
# outSAMtype BAM SortedByCoordinate: Sorts output by coordinate
# alignSoftClipAtReferenceEnds: prohibits soft clipping of alignments past ends of chromosomes, useful for cufflinks compatibility
