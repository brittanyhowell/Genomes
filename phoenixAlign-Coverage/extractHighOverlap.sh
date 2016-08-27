#!/bin/bash


BEDDIR=/data/rc003/Brittany/Coverage/Active_clustered
ELEMENTS="2"



cd ${BEDDIR}


for file in *.bed; do 

OUTFILE="${file%.coverage.bed}.cov_${ELEMENTS}.bed"

	awk '{
		if ($7 >= '${ELEMENTS}')
			print $0 }' ${file} >> ${OUTFILE}

done
echo "complete"


