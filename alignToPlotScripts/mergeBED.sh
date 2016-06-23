#!/bin/bash
## mergeBED merges two BED files.

echo "commencing"

BEDDIR=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1_CGTACG_L007
OUTDIR=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1_CGTACG_L007-both-ORF2

cd ${BEDDIR}

for file in *bothORF.bed ; do  

filename=${file%-bothORF.bed}


 cat ${filename}-bothORF.bed >> ${filename}-bothORF-ORF2.bed
 cat ${filename}-ORF2only.bed >> ${filename}-bothORF-ORF2.bed

# mv ${filename}-bothORF-ORF2.bed ${OUTDIR}
done 

echo "complete"