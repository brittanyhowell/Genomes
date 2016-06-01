## Script aligns mouse HENMT2 reads to mm10 using STAR, then calculates coverage and plots with R.
## Date: 31-5-2016

# Working folders
rawDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/raw_data
indexedDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/indexedGenomes/indexedMouse/
alignDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/aligned_reads
alignOutDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/Data/TranscriptomeData/Henmt1_mRNAseq_mouse/AlignmentOutputData

#Alignment parameters 
MULTIMAP=("20" "25" "30" "35" "40" "45")
MISMATCH=("2" "5" "10" "15" "20")

# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1.fastq.gz)

for file in ${READ}
do
	for iMap in "${MULTIMAP[@]}"; do

		for iMatch in "${MISMATCH[@]}"; do

			readname=${file%_R1.fastq.gz}

				



			#Run STAR
			STAR --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}_R1.fastq.gz ${rawDIR}/${readname}_R2.fastq.gz --outFilterMismatchNmax ${MISMATCH} --outFilterMultimapNmax ${MULTIMAP} --outFileNamePrefix ${alignDIR}/${readname}.STAR. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No 

			# Make bam index
			samtools index ${readname}.STAR.Aligned.sortedByCoord.out.bam

			# Move alignment information files into separate folder
			mv ${readname}.STAR.Log.out ${alignOutDIR}
			mv ${readname}.STAR.Log.final.out ${alignOutDIR}
			mv ${readname}.STAR.Log.progress.out ${alignOutDIR}
		done

	done

done

