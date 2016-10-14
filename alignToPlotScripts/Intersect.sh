#!/bin/bash
## Script intersects them with L1 locations
## Date: 10-6-2016

# Working folders
BEDDir=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/BEDs
COORDDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/L1Location
COORD=L1_mouseORF1-2-4-8kb.bed
OUTDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/BEDs/Intersected

# File names
TAIL="Active.bed"
trunc="STAR.10.45.Aligned.sortedByCoord.out.bed"

#Purpose of run
DETAILS="Rerunning intersect with active coordinates from Atma"

# record
recordDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/Records
record=${recordDIR}/intersectActive.txt 
error=${recordDIR}/intersectActive.err
RecordError=${recordDIR}/intersectActive.err.log

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

filename=${file%${trunc}}
	
	echo "Commencing intersect for ${filename}" >> ${record} 2>&1
	echo "Commencing intersect for ${filename}"
	bedtools intersect -a  ${BEDDir}/${file} -b  ${COORDDIR}/${COORD} > ${OUTDIR}/${filename}.${TAIL} 2> ${error}
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

