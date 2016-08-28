#!/bin/bash
# Script extracts all elements with a high depth of coverage 
# and places them into a nice BED again


BEDDIR=/data/rc003/Brittany/Coverage/AllL1sClus
DAC="1.9"


cd ${BEDDIR}

for file in *coverage.bed; do 

	# Filename changes
	Filename="${file%.coverage.bed}"
	OUTFILE="${Filename}.cov_${DAC}.bed"

	# Check if outfile exists
	if [ -f ${OUTFILE} ]; then
		rm ${OUTFILE}
	    echo "${OUTFILE} exists... removing" 
	else
	    echo "${OUTFILE} did not exist... Calculating" 
	fi

	cat ${file} | awk '{if ($7 > 0.5 ) print}'| awk '{print $0 "\t" (($7/$8)*101)}' | awk '{if ($11 >= '${DAC}') print}'> ${OUTFILE}

done


echo "complete"
