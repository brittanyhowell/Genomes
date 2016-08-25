#!/bin/bash
## Script intersects Bams with L1 locations (BED)
## Date: 10-8-2016

# Invoked by: BAMDir=/data/rc003/Brittany/Alignment/bamMouse COORDDIR=/data/rc003/Brittany/Data/L1Location COORD=L1_mouseORF1-2-4-8kb.bed OUTDIR=/data/rc003/Brittany/Alignment/intersect sbatch bamLowIntersect.sh

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8 
#SBATCH --time=0-04:00
#SBATCH --mem=20GB 

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b

# # Working folders
# BAMDir=/data/rc003/Brittany/Alignment/bamMouse
# COORDDIR=/data/rc003/Brittany/Data/L1Location
# COORD=L1_mouseORF1-2-4-8kb.bed
# OUTDIR=/data/rc003/Brittany/Alignment/intersect

# File names
TAIL="O2.bO.bam"

# Check BAMDir exists 
if [ -d $BAMDir ]; then
	echo "Bam folder intact"
else 
	echo "Bam folder missing..."
	exit
fi 

# Check OUTDIR exists 
if [ -d $OUTDIR ]; then
	rm -r $OUTDIR 
	mkdir $OUTDIR
	echo "OUT folder exists... replacing"
else 
	echo "creating OUT folder" 
	mkdir $OUTDIR
fi 

cd ${BAMDir}

for file in *.bam ; do 

filename=${file%.bam}

	echo "Commencing intersect for ${filename}"
	intersectBed -abam  ${file} -b  ${COORDDIR}/${COORD} > ${OUTDIR}/${filename}.${TAIL} 
	echo "Finished intersect"

done

echo "Complete"

