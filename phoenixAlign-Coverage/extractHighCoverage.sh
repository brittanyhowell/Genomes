#!/bin/bash

TEMPFILE=HighCov.txt
NUMFILE=HighCovL1s.txt
BEDDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Combined


cd ${BEDDIR}
touch ${TEMPFILE}
touch ${NUMFILE}

COVERAGE=("0.8" "0.85" "0.9" "0.95" "1")

for coverage in "${COVERAGE[@]}"; do 
echo "completing ${coverage}"
	awk '{
		if ($10 >= '${coverage}')
			print $0 }' AllMut.STAR.O2.bO.coverage.bed >> temp_${coverage}_${TEMPFILE}
	
	NumSeq=$(wc -l temp_${coverage}_${TEMPFILE})

	echo ${NumSeq}

done
rm temp*
complete