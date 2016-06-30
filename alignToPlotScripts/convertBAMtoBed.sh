#!/bin/bash
## Script converts bam files to BEDs and then intersects them with L1 locations
## Date: 10-6-2016

# Working folders
TestAlignDIR=/mnt/project/Data/Mouse/tempBAMS/TEMPBAM
BEDDir=/mnt/project/Data/Mouse/BED/Mut-F2-Rep1_CGTACG_L007TEMP
record=/mnt/project/Data/Mouse/Scripts/record/recordBAMtoBEDRep1TEMP.txt 
error=/mnt/project/Data/Mouse/Scripts/record/recordBAMtoBEDRep1TEMP.err 


if [ -f ${record} ]; then
	rm ${record}
	touch ${record}
    echo "${record} exists, replacing" >> ${record} 2>&1
else
    touch ${record}
    echo "${record} did not exist, now does" >> ${record} 2>&1
fi

echo "Commencing program">> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1

if [ -f ${error} ]; then
	rm ${error}
	touch ${error}
    echo "${error} exists, replacing" >> ${record} 2>&1
else
    touch ${error}
    echo "${error} did not exist, now does" >> ${record} 2>&1
fi

# Check BED folder exists, if not, make it
	if [ -d $BEDDir ]; then
		rm -r $BEDDir 
		mkdir $BEDDir
		echo "BED folder exists... replacing" >> ${record} 2>&1
	else 
		echo "creating BED folder" >> ${record} 2>&1
		mkdir $BEDDir
	fi 


# Make BEDs
cd $TestAlignDIR

# Remove any semi-made BEDs
if [ -f *.bed ]; then
	rm *.bed 
	echo "Removed BED in progress" >> ${record} 2>&1
else 
	echo "No BEDs in progress" >> ${record} 2>&1
fi 

for file in *.bam ; do 
	
	readname=${file%.bam}
	
	# Move into BEDDir to see if a BED has already been made
	cd $BEDDir

	if [ -f ${readname}.bed ]; then
		echo "${readname}.bed exists" >> ${record} 2>&1
		cd $TestAlignDIR
	else
	  # Move back into alignment folder so files can be accessed
  	  cd $TestAlignDIR
  	  echo "converting BAM to BED" >> ${record} 2>&1
  	  bedtools bamtobed -i $file > $readname.bed; 2>${error}
  	  mv ${readname}.bed $BEDDir
	fi	
	

done
echo "Completed program" >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1

cat ${record} | mail -s "Finished conversion" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1



