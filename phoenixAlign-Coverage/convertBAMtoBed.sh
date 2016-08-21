#!/bin/bash

# Invoked by:
#
# TestAlignDIR=/data/rc003/Brittany/Alignment/intersect/Clus BEDDir=/data/rc003/Brittany/Alignment/BED/Clus sbatch BamToBed.sh
#

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8  				
#SBATCH --time=0-04:00  	
#SBATCH --mem=30GB 			

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL           
#SBATCH --mail-user=brittany.howell@student.adelaide.edu.au      


# Load the necessary modules
module load BEDTools/2.25.0-foss-2015b

# Working folders
#TestAlignDIR=/data/rc003/Brittany/Alignment/intersect/Clus
#BEDDir=/data/rc003/Brittany/Alignment/BED/Clus


# Check BED folder exists, if not, make it
	if [ -d $BEDDir ]; then
		rm -r $BEDDir 
		mkdir $BEDDir
		echo "BED folder exists... replacing"  
	else 
		echo "creating BED folder"  
		mkdir $BEDDir
	fi 


# Make BEDs
cd $TestAlignDIR

# Remove any semi-made BEDs
if [ -f *.bed ]; then
	rm *.bed 
	echo "Removed BED in progress"  
else 
	echo "No BEDs in progress"  
fi 

for file in *.bam ; do 
	
	readname=${file%.bam}
	
	# Move into BEDDir to see if a BED has already been made
	cd $BEDDir

	if [ -f ${readname}.bed ]; then
		echo "${readname}.bed exists"  
		cd $TestAlignDIR
	else
	  # Move back into alignment folder so files can be accessed
  	  cd $TestAlignDIR
  	  echo "converting ${readname} BAM to BED" 
  	  bedtools bamtobed -i $file > $readname.bed; 
  	  mv ${readname}.bed $BEDDir
	fi	
done
echo "Completed program"  
