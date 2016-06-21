#!/bin/bash
## Script converts bam files to BEDs and then intersects them with L1 locations
## Date: 10-6-2016

# Working folders
TestAlignDIR=/mnt/project/Data/Mouse/alignedReads/Mut-F2-Rep1_CGTACG_L007
locationL1DIR=/mnt/project/Data/location
BEDDir=/mnt/project/Data/Mouse/BED


# Check BED folder exists, if not, make it
	if [ -d $BEDDir ]; then
		rm -r $BEDDir 
		echo "BED folder exists"
	else 
		echo "creating BED folder"
		mkdir $BEDDir
	fi 
# Convert bam to BED

# Make BEDs
cd $TestAlignDIR

for file in *.bam ; do 
	
	readname=${file%.bam}
	
	# Move into BEDDir to see if a BED has already been made
	cd $BEDDir

	if [ -f ${readname}.bed ]; then
		echo "${readname}.bed exists"
		cd $TestAlignDIR
	else
	  # Move back into alignment folder so files can be accessed
  	  cd TestAlignDIR
  	  echo "converting BAM to BED"
  	  bedtools bamtobed -i $file > $file.bed;
  	  mv $file.bed $BEDDir
	fi	
	

done

