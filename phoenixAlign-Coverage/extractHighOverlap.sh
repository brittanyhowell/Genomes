#!/bin/bash

TEMPFILE=HighCov.txt
NUMFILE=HighCovL1s.txt
BEDDIR=/data/rc003/Brittany/Alignment/CoverageClus
ELEMENTS="2"
OUTFILE="${BED%.coverage.bed}.cov_${ELEMENTS}.bed"


cd ${BEDDIR}
echo pwd

touch ${OUTFILE}

for file in *.bed; do 
echo ${file}
	awk '{
		if ($7 >= '${ELEMENTS}')
			print $0 }' ${file} >> ${OUTFILE}

done



