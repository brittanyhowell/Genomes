#!/bin/bash
## mergeBED merges two BED files.

echo "commencing"

BEDDIR=/mnt/project/Data/Mouse/locationMouse
#OUTDIR=/mnt/project/Data/Mouse/intersect/Mut-F2-Rep1_CGTACG_L007-both-ORF2

cd ${BEDDIR}

#for file in *bothORF.bed ; do  

#filename=${file%-bothORF.bed}


 cat L1_Mouse_bothorf.bed >> L1_Mouse_merge_ORF2only-bothORF.bed
 cat L1_Mouse_orf2only.bed >> L1_Mouse_merge_ORF2only-bothORF.bed


# mv ${filename}-bothORF-ORF2.bed ${OUTDIR}
#done 
bedtools sort -i L1_Mouse_merge_ORF2only-bothORF.bed > L1_Mouse_merge_sort_ORF2only-bothORF.bed

echo "complete"