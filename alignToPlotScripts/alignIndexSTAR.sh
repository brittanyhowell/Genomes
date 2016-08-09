#!/bin/bash
## alignIndexSTAR.sh aligns mouse HENMT2 reads to mm10 using STAR,
## Date: 31-5-2016
# Invoked by:
#
# rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/combinedRaw indexedDIR=/data/rc003/Brittany/genomes/indexedMouse alignDIR=/data/rc003/Brittany/Alignment/bamMouse alignOutDIR=/data/rc003/Brittany/Alignment/outputMouse sbatch STAR.sh
#

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-09:00
#SBATCH --mem=50GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b
module load STAR/2.5.1a-foss-2015b
module load SAMtools/1.2-foss-2015b


# # Raw folders
# rawDIR=/data/rc003/Brittany/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/combinedRaw
# indexedDIR=/data/rc003/Brittany/genomes/indexedMouse

# #Output
# alignDIR=/data/rc003/Brittany/Alignment/bamMouse
# alignOutDIR=/data/rc003/Brittany/Alignment/outputMouse


# Check all folders exist

if [ -d $rawDIR ]; then
    echo "Folder $rawDIR exists ..." 
else
    mkdir $rawDIR
    echo "Folder $rawDIR does not exist"     
    exit
fi

if [ -d $indexedDIR ]; then
    echo "Folder $indexedDIR exists ..." 
else
    mkdir $indexedDIR
    echo "Folder $indexedDIR does not exist"     
    exit
fi

if [ -d $alignDIR ]; then
    echo "Folder $alignDIR exists ... replacing"     
    rm -r ${alignDIR}
    mkdir ${alignDIR}
else
    mkdir $alignDIR
    echo "Folder $alignDIR does not exist, making $alignDIR" 
fi

if [ -d $alignOutDIR ]; then
    echo "Folder $alignOutDIR exists ... replacing"     
    rm -r ${alignOutDIR}
    mkdir ${alignOutDIR}
else
    mkdir $alignOutDIR
    echo "Folder $alignOutDIR does not exist, making $alignOutDIR" 
fi


# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1*)

for file in ${READ}; do

	readname=${file%_R1.fastq}

	echo "Running STAR for ${readname}" 		

	#Run STAR
 STAR --runThreadN 8 --genomeDir ${indexedDIR} --genomeLoad LoadAndKeep --readFilesIn ${rawDIR}/${readname}_R1.fastq ${rawDIR}/${readname}_R2.fastq --outFilterMismatchNmax 7 --outFilterMultimapNmax 50 --outFileNamePrefix ${alignDIR}/${readname}.STAR. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No 

		cd ${alignDIR}

	# Make bam index
	echo "Making bam index" 
    samtools index ${readname}.STAR.Aligned.sortedByCoord.out.bam 

	# Move alignment information files into separate folder
	mv ${readname}.STAR.Log.out ${alignOutDIR} 
	mv ${readname}.STAR.Log.final.out ${alignOutDIR} 
	mv ${readname}.STAR.Log.progress.out ${alignOutDIR} 


done

