#!/bin/bash

TEMPFILE=HighCov.txt
NUMFILE=HighCovL1s.txt
BEDDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Combined
BED=AllMut.STAR.active.coverage.bed 
OUTFILE=temp_${ELEMENTS}_${TEMPFILE}
Elements="2"


cd ${BEDDIR}
touch ${TEMPFILE}
touch ${NUMFILE}



for file in *.bed; do 
	awk '{
		if ($7 >= '${ELEMENTS}')
			print $0 }' ${file} >> 
	
	NumSeq=$(wc -l temp_${ELEMENTS}_${TEMPFILE})

	echo ${NumSeq}

done
rm temp*
complete



