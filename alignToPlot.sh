## Script aligns mouse HENMT2 reads to mm10 using STAR, then calculates coverage and plots with R.
## Date: 31-5-2016

# Working folders
rawDIR=/mnt/project/Data/Mouse/rawReads
indexedDIR=/mnt/project/Data/Mouse/indexedMouse
alignDIR=/mnt/project/Data/Mouse/alignedReads
alignOutDIR=/mnt/project/Data/Mouse/AlignmentOutputData
record=/mnt/project/Data/Mouse/record.txt 

if [ -f ${record} ]; then
	rm ${record}
	touch ${record}
    echo "${record} exists, replacing" >> ${record} 2>&1
else
    touch ${record}
    echo "${record} did not exist, now does" >> ${record} 2>&1
fi


echo "The program starts at:" >> ${record} 2>&1
date >> ${record} 2>&1

# Check all folders exist

if [ -d $rawDIR ]; then
    echo "Folder $rawDIR exists ..." >> ${record} 2>&1
else
    mkdir $rawDIR
    echo "Folder $rawDIR does not exist, making $rawDIR" >> ${record} 2>&1
fi

if [ -d $indexedDIR ]; then
    echo "Folder $indexedDIR exists ..." >> ${record} 2>&1
else
    mkdir $indexedDIR
    echo "Folder $indexedDIR does not exist, making $indexedDIR" >> ${record} 2>&1
fi

if [ -d $alignDIR ]; then
    echo "Folder $alignDIR exists ..." >> ${record} 2>&1
else
    mkdir $alignDIR
    echo "Folder $alignDIR does not exist, making $alignDIR" >> ${record} 2>&1
fi

if [ -d $alignOutDIR ]; then
    echo "Folder $alignOutDIR exists ..." >> ${record} 2>&1
else
    mkdir $alignOutDIR
    echo "Folder $alignOutDIR does not exist, making $alignOutDIR" >> ${record} 2>&1
fi

#Alignment parameters 
MULTIMAP=("20" "25" "30" "35" "40" "45")
MISMATCH=("2" "5" "10" "15" "20")

echo "Commencing alignments" >> ${record} 2>&1
date >> ${record} 2>&1

# Move into reads folder
cd ${rawDIR}
READ=$(ls *_R1.fastq.gz)

for file in ${READ}; do

	for iMap in "${MULTIMAP[@]}"; do

		for iMatch in "${MISMATCH[@]}"; do

			readname=${file%_R1.fastq.gz}

			echo "Running STAR for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			date >> ${record} 2>&1

			#Run STAR
			STAR --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}_R1.fastq.gz ${rawDIR}/${readname}_R2.fastq.gz --outFilterMismatchNmax ${iMatch} --outFilterMultimapNmax ${iMap} --outFileNamePrefix ${alignDIR}/${readname}.STAR. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No  \ 
	 2> ${record} 

	 		cd ${alignDIR}
			# Make bam index
			samtools index ${readname}.STAR.Aligned.sortedByCoord.out.bam 2> ${record} 

			# Move alignment information files into separate folder
			mv ${readname}.STAR.Log.out ${alignOutDIR} 2> ${record}
			mv ${readname}.STAR.Log.final.out ${alignOutDIR} 2> ${record}
			mv ${readname}.STAR.Log.progress.out ${alignOutDIR} 2> ${record}

			echo "Completed alignment for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			date >> ${record} 2>&1

			cd ${rawDIR}

		done

	done

	mail -s "${READ} finished" brittany.howell@student.adelaide.edu.au < record=/mnt/project/Data/Mouse/record.txt 

done

echo "Exiting program" >> ${record} 2>&1
