#!/bin/bash
# Script extracts all elements with a high depth of coverage 
# and places them into a nice BED again


BEDDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ReadCoverage/Combined/Active
DAC="2"


cd ${BEDDIR}

for file in *.bed; do 

	# Filename changes
	Filename="${file%.coverage.bed}"
	OUTFILE="${Filename}.cov_${DAC}.bed"

	# Check if outfile exists
	if [ -f ${OUTFILE} ]; then
		rm ${OUTFILE}
	    echo "${OUTFILE} exists... removing" 
	else
	    echo "${OUTFILE} did not exist" 
	fi

	cat ${file} | awk '{if ($7 > 0.5 ) print}'| awk '{print $0 "\t" (($7/$8)*101)}' > ${OUTFILE}

done



