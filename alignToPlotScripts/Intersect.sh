#!/bin/bash
## Script converts bam files to BEDs and then intersects them with L1 locations
## Date: 10-6-2016

# Working folders
BEDDir=/mnt/project/Data/Mouse/BED/Mut-F2-Rep1_CGTACG_L007
record=/mnt/project/Data/Mouse/Scripts/record/recordIntersectRep1.txt 
COORDDIR=/mnt/project/Data/Mouse/locationMouse
OUTDIR=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1_CGTACG_L007
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

echo "Commencing program">> ${record} 2>&1
$ADEDATE >> ${record} 2>&1

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
	bedtools intersect -a  ${BEDDir}/${file} -b  ${COORDDIR}/L1_Mouse_bothorf.bed > ${OUTDIR}/${filename}-bothorf.bed

done

echo "Completed program" >> ${record} 2>&1
$ADEDATE >> ${record} 2>&1

cat ${record} | mail -s "Finished Intersect" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1