#!/bin/bash

STAR --genomeDir ../mouse/indexed/ --readFilesIn Mut-F2-Rep1_CGTACG_L007_R1.fastq Mut-F2-Rep1_CGTACG_L007_R2.fastq --outFilterMismatchNmax 2 --outFilterMultimapNmax 20 --outFileNamePrefix ../mouse/output/mm10 --outSAMstrandField intronMotif --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No 




# Removed outSAMattributes All - because I'm not sure it "All" is correct