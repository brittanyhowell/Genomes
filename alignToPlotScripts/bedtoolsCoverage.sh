#!/bin/bash

# Data folders
READS=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1-Last2
L1DIR=/mnt/project/Data/Mouse/locationMouse
L1=L1_Mouse_merge_sort_ORF2only-bothORF.bed
OUTDIR=/mnt/project/Coverage/Mut-F2-Rep1_CGTACG_L007-Last2

# File name changes
trunc=".Aligned.sortedByCoord.out.O2.bO.bed"
newName=".O2.bO.coverage.bed"

#Purpose of run
DETAILS="Last 2. These ones failed"

# Keeping records
recordDIR=/mnt/project/Coverage/Scripts/record/
record=/mnt/project/Coverage/Scripts/record/recordCoverage-Last2.txt 
error=/mnt/project/Coverage/Scripts/record/recordCoverage-Last2.err
RecordError=/mnt/project/Coverage/Scripts/record/recordCoverage-Last2.err.log 


# Check and make record
if [ -f ${record} ]; then
	rm ${record}
	touch ${record}
    echo "${record} exists, replacing" >> ${record} 2>&1
else
    touch ${record}
    echo "${record} did not exist, now does" >> ${record} 2>&1
fi


# Check and make error.log
if [ -f ${error} ]; then
	rm ${error}
	touch ${error}
    echo "${error} exists, replacing" >> ${record} 2>&1
else
    touch ${error}
    echo "${error} did not exist, now does" >> ${record} 2>&1
fi

# Check and make RecordErr.log
if [ -f ${RecordError} ]; then
	rm ${RecordError}
	touch ${RecordError}
    echo "${RecordError} exists, replacing" >> ${record} 2>&1
else
    touch ${RecordError}
    echo "${RecordError} did not exist, now does" >> ${record} 2>&1
fi

echo "Commencing time: " >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1
echo "Commencing time: " >> ${error} 2>&1
TZ=Australia/Adelaide date >> ${error} 2>&1

echo ${DETAILS} >> ${record} 2>&1

# Check OUTDIR exists 
if [ -d $OUTDIR ]; then
	rm -r $OUTDIR 
	mkdir $OUTDIR
	echo "OUT folder exists... replacing" >> ${record} 2>&1
else 
	echo "creating OUT folder" >> ${record} 2>&1
	mkdir $OUTDIR
fi

# Calculate coverage
cd ${READS}
# Remove any semi-complete coverage files
if [ -f *.coverage.bed ]; then
	rm *.coverage.bed 
	echo "Removed coverage file in progress" >> ${record} 2>&1
else 
	echo "No coverage files in progress" >> ${record} 2>&1
fi 


for iRead in *.bed; do

	#Trim filename
	filename=${iRead%${trunc}}

	echo "Calculating coverage for ${filename}" >> ${record} 2>&1

	bedtools coverage -F 0.2 -s -split  -a ${L1DIR}/${L1}  -b ${READS}/${iRead} > ${filename}${newName} 2>${error}

	# Move coverage file into outDIR 
	mv ${filename}${newName} ${OUTDIR}
	echo "Finished ${iRead}"

done

echo "Completing time: " >> ${record} 2>&1
TZ=Australia/Adelaide date >> ${record} 2>&1
echo "Completing time: " >> ${error} 2>&1
TZ=Australia/Adelaide date >> ${error} 2>&1

# Make combined record file
cd ${recordDIR}
echo "Record file:" >> ${RecordError}
cat recordCoverage.txt >> ${RecordError}
echo "" >> ${RecordError}
echo "Error file:" >> ${RecordError}
cat recordCoverage.err.log >> ${RecordError}

# Send combined record file
cat RecordErr.log | mail -s "Finished Coverage" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1

echo "complete"



# -hist: makes histograms and additional data 
# -d: records depth at each L1 position
# -F: Minimum overlap with read (0.2 = ~20bp)
# -s: forces strandedness
# -split: treats cigar string split reads as two different reads