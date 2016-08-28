#!/bin/bash
## Script invokes Bedcoverage
## Date: 10-8-2016

# Invoked by: READS=/data/rc003/Brittany/intersect/BED/ActiveAtma L1DIR=/data/rc003/Brittany/Data/L1Location L1=ClusActiveL1s.bed  OUTDIR=/data/rc003/Brittany/Coverage/RetryActiveWithClus sbatch covClus.sh 

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8 
#SBATCH --time=0-01:00
#SBATCH --mem=10GB 

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b

# # Data folders
# READS=/data/rc003/Brittany/intersect/BED/ActiveAtma
# L1DIR=/data/rc003/Brittany/Data/L1Location
# L1=ClusActiveL1s.bed 
# OUTDIR=/data/rc003/Brittany/Coverage/RetryActiveWithClus

# File name changes
trunc=".Aligned.sortedByCoord.out.Active.bed"
newName=".active.Clus.coverage.bed"


# Check OUTDIR exists 
if [ -d $OUTDIR ]; then
	rm -r $OUTDIR 
	mkdir $OUTDIR
	echo "OUT folder exists... replacing"  
else 
	echo "creating OUT folder"  
	mkdir $OUTDIR
fi

# Calculate coverage
cd ${READS}

# Remove any semi-complete coverage files
if [ -f *.coverage.bed ]; then
	rm *.coverage.bed 
	echo "Removed coverage file in progress"  
else 
	echo "No coverage files in progress"  
fi 


for iRead in *.bed; do

	#Trim filename
	filename=${iRead%${trunc}}

	echo "Calculating coverage for ${filename}"  

	bedtools coverage -F 0.2 -s -split  -a ${L1DIR}/${L1}  -b ${READS}/${iRead} > ${filename}${newName}

	# Move coverage file into outDIR 
	mv ${filename}${newName} ${OUTDIR}
	echo "Finished ${iRead}"

done

echo "complete"
