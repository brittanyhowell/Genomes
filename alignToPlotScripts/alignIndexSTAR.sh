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
    echo "Folder $alignDIR exists ... replacing" >> ${record} 2>&1
    rm -r ${alignDIR}
    mkdir ${alignDIR}
else
    mkdir $alignDIR
    echo "Folder $alignDIR does not exist, making $alignDIR" >> ${record} 2>&1
fi

if [ -d $alignOutDIR ]; then
    echo "Folder $alignOutDIR exists ... replacing" >> ${record} 2>&1
    rm -r ${alignOutDIR}
    mkdir ${alignOutDIR}
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
READ=$(ls *_R1.fastq)

for file in ${READ}; do

	for iMap in "${MULTIMAP[@]}"; do

		for iMatch in "${MISMATCH[@]}"; do

			readname=${file%_R1.fastq}

			echo "Running STAR for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			

			#Run STAR
			STAR --genomeDir ${indexedDIR} --readFilesIn ${rawDIR}/${readname}_R1.fastq ${rawDIR}/${readname}_R2.fastq --outFilterMismatchNmax ${iMatch} --outFilterMultimapNmax ${iMap} --outFileNamePrefix ${alignDIR}/${readname}.STAR.${iMatch}.${iMap}. --outSAMstrandField intronMotif --outSAMattributes All --outSAMtype BAM SortedByCoordinate --alignSoftClipAtReferenceEnds No  

	 		cd ${alignDIR}
			# Make bam index
			echo "Making bam index" >> ${record} 2>&1
			samtools index ${readname}.STAR.${iMatch}.${iMap}.Aligned.sortedByCoord.out.bam 

			# Move alignment information files into separate folder
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.out ${alignOutDIR} 
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.final.out ${alignOutDIR} 
			mv ${readname}.STAR.${iMatch}.${iMap}.Log.progress.out ${alignOutDIR} 

			echo "Completed alignment for ${readname} with ${iMap} multimapping and ${iMatch} mismatches" >> ${record} 2>&1
			date >> ${record} 2>&1


			cd ${rawDIR}

		done

	done
	

	gzip Mut-F2-Rep1_CGTACG_L007_R1.fastq
	gzip Mut-F2-Rep1_CGTACG_L007_R2.fastq

	cd /mnt/project/Data/Mouse/
	
	cat record.txt | mail -s "finished" brittany.howell1@gmail.com 
	echo "Email sent"  >> ${record} 2>&1

done

echo "Exiting program" >> ${record} 2>&1
