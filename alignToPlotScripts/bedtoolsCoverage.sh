#!/bin/bash

READS=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1_CGTACG_L007
L1=/mnt/project/Data/Mouse/locationMouse
recordDIR=/mnt/project/Coverage/Scripts/record/
record=/mnt/project/Coverage/Scripts/record/recordCoverage.txt 
error=/mnt/project/Coverage/Scripts/record/recordCoverage.err.log 
OUTDIR=/mnt/project/Coverage/Mut-F2-Rep1_CGTACG_L007
ADEDATE=$(TZ="Australia/Adelaide" date)

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

echo "Commencing time: $ADEDATE" >> ${record} 2>&1
echo "Commencing time: $ADEDATE" >> ${error} 2>&1

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
	filename=${iRead%.Aligned.sortedByCoord.out-bothorf.bed}

	echo "Calculating coverage for ${filename} at ${ADEDATE}" >> ${record} 2>&1

	bedtools coverage -F 0.2 -s -split -d  -a ${L1}/L1_Mouse_bothorf.bed  -b ${READS}/${iRead} > ${filename}.bothorf.coverage.bed 2>${error}

	# Move coverage file into outDIR 
	mv ${filename}.bothorf.coverage.bed ${OUTDIR}

	cat ${record} | mail -s "Finished coverage for file" brittany.howell1@gmail.com 
done

echo "Completing time: $ADEDATE" >> ${record} 2>&1
echo "Completing time: $ADEDATE" >> ${error} 2>&1

# Make combined record file
cd ${recordDIR}
echo "Record file:" > RecordErr.log 
cat recordCoverage.txt >> RecordErr.log 
echo "" >> RecordErr.log 
echo "Error file:" >> RecordErr.log 
cat recordCoverage.err.log >> RecordErr.log

cat RecordErr.log | mail -s "Finished All coverage at $ADEDATE" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1

echo "complete"



# -hist: makes histograms and additional data 
# -d: records depth at each L1 position
# -F: Minimum overlap with read (0.2 = ~20bp)
# -s: forces strandedness
# -split: treats cigar string split reads as two different reads