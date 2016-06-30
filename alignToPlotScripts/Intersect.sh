#!/bin/bash
## Script intersects them with L1 locations
## Date: 10-6-2016

# Working folders
BEDDir=/mnt/project/Data/Mouse/BED/Mut-F2-Rep1_CGTACG_L007TEMP
COORDDIR=/mnt/project/Data/Mouse/locationMouse
COORD=L1_Mouse_merge_sort_ORF2only-bothORF.bed
OUTDIR=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1-TEMP

#Purpose of run
DETAILS="The data used is a bigger subset of the second round of alignments, which have a larger number of parameters. Only the 20 and 25 multimapping group is being used to get a picture of the results so far."

# record
recordDIR=/mnt/project/Coverage/Scripts/record/
record=/mnt/project/Data/Mouse/Scripts/record/recordIntersectRep1TEMP.txt 
error=/mnt/project/Data/Mouse/Scripts/record/recordIntersectRep1TEMP.err
RecordError=/mnt/project/Data/Mouse/Scripts/record/recordIntersectRep1TEMP.err.log

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
echo "Commencing program">> ${record} 2>&1
TZ=Australia/Adelaide date  >> ${record} 2>&1

echo ${DETAILS} >> ${record} 2>&1

if [ -f ${error} ]; then
	rm ${error}
	touch ${error}
    echo "${error} exists, replacing" >> ${record} 2>&1
else
    touch ${error}
    echo "${error} did not exist, now does" >> ${record} 2>&1
fi

# Check and make RecordError
if [ -f ${RecordError} ]; then
	rm ${RecordError}
	touch ${RecordError}
    echo "${RecordError} exists, replacing" >> ${record} 2>&1
else
    touch ${RecordError}
    echo "${RecordError} did not exist, now does" >> ${record} 2>&1
fi

# Check OUTDIR exists 
if [ -d $OUTDIR ]; then
	rm -r $OUTDIR 
	mkdir $OUTDIR
	echo "OUT folder exists... replacing" >> ${record} 2>&1
else 
	echo "creating OUT folder" >> ${record} 2>&1
	mkdir $OUTDIR
fi 

cd ${BEDDir}

for file in *.bed ; do 

filename=${file%.bed}
	
	echo "Commencing intersect for ${filename}" >> ${record} 2>&1
	echo "Commencing intersect for ${filename}"
	bedtools intersect -a  ${BEDDir}/${file} -b  ${COORDDIR}/${COORD} > ${OUTDIR}/${filename}.O2.bO.bed 2> ${error}
	echo "Finished intersect"

done

# Make combined record file
cd ${recordDIR}
echo "Record file:" >> ${RecordError}
cat ${record} >> ${RecordError}
echo "" >> ${RecordError}
echo "Error file:" >> ${RecordError}
cat ${error} >> ${RecordError}



echo "Completed program" >> ${record} 2>&1
TZ=Australia/Adelaide date  >> ${record} 2>&1

cat ${record} | mail -s "Finished Intersect" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1
echo "Complete"

